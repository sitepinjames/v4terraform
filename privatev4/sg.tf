module "security-group" {
    source = "terraform-aws-modules/security-group/aws"
    version = "4.17.2"

    for_each = local.sec_groups

    name = each.value.name
    description = each.value.sg_description
    vpc_id = data.aws_vpc.this.id
    ingress_with_cidr_blocks = each.value["ingress_with_cidr_blocks"]
    egress_with_cidr_blocks = each.value["egress_with_cidr_blocks"]
    ingress_with_self = each.value["ingress_with_self"]
    egress_with_self = each.value["egress_with_self"]
    ingress_with_source_security_group_id = each.value["ingress_with_source_security_group_id"]
    egress_with_source_security_group_id = each.value["egress_with_source_security_group_id"]
    tags = local.tags
}
