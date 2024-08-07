# Make the EC2 instance able to use IAM roles

data "aws_iam_policy_document" "ec2_assume_role" {
    statement {
        actions = ["sts:AssumeRole"]

        principals {
            type = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }
    }
}

resource "aws_iam_role" "ec2_instace_role" {
    name = format("%s-%s-iam-role", local.tags["u_squad"], local.sys_name)
    path = "/"
    assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.jsonencode
    tags = local.tags
}

resource "aws_iam_policy" "ec2_instance_policy" {
    name = format("%s-%s-ec2-readwrite-iam-policy", var.tags["u_squad"], var.sys_name)
    description = format("LinuxOps %s EC2 access for KMS", var.sys_name)
    path = "/"
    policy = templatefile("${path.module}/templates/ec2_policy.json.tftpl", {
        kms_key_arn = aws_kms_key.key.arn
    })
    tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ec2_instance_policy" {
    role = aws_iam_role.ec2_instance_role.name
    policy_arn = aws_iam_policy.ec2_instance_policy.arn
}

resource "aws_iam_instance_profile" "ec2" {
    name = format("%s-%s-iam-ec2profile", local.tags["u_squad"], local.sys_name)
    role = aws_iam_role.ec2_instance_role.name
    tags = local.tags
}

resource "aws_iam_policy_attachment" "ssm_managed"{
    role = aws_iam_role.ec2_instance_role.name
    policy_arn = data.aws_iam_policy.ssm_managed.arn
}