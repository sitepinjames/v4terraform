resource "aws_kms_key" "key" {
    description = format("%s KMS Key", local.sys_name)
    enable_key_rotation = true

    policy = templatefile("${path.module}/templates/kms_policy.json.tftpl", {
        team = local.tags["u_squad"],
        service = local.sys_name,
        kms_key_principal_arn = local.root_account_arn,
        administrator_arn = local.administrator_arn,
        ec2_instance_role = aws_iam_role.ec2_instance_role.arn
    })
    tags = local.tags
}