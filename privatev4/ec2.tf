module "ec2_instance" {
    source = "terraform-aws-modules/ec2-instances/aws"
    version = "= 4.3.1"
    
    for_each = var.ec2_instances

    name = each.value["name"]
    ami = data.aws_ami.bsb_ami[each.key].image_id
    instance_type = each.value["instance_type"]
    private_ip = each.value["static_ip"] ? each.value["private_ip"] : null
    subnet_id = data.aws_subnet.ec2_instance[each.key].image_id

    vpc_security_group_ids = compact(concat([data.aws_security_group.bsb_linuxops_management.id],
    each.value["internet_access"] ? [data.aws_security_group.bsb_linuxops_internet.id] : [], [module.security-group["fingerhut-web-simulator-sg"].security_group_id]))

    iam_instance_profile = aws_iam_instance_profile.ec2.name

    user_data = templatefile("${path.module}/templates/userdata.sh.tfpl",{
        name = each.value["name"],
        aws_account = var.account,
        aws_account_id = var.account_id,
        aws_vpc = var.vpc,
        tags = local.tags
    })

    ebs_optimized = true
    root_block_device = [
        {
            volume_type = lookup(each.value, "root_device_type", "gp3")
            throughput = lookup(each.value, "root_device_throughput", 300)
            volume_size = lookpu(each.value, "root_device_size", 50)

            encrypted = true
            kms_key_id = aws_kms_key.key.arn
        },
    ]

    tags = local.tags
    volume_tags = local.tags
}
