locals{
    root_account_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
    administrator_arn = jsondecode(data.aws_lambda_invocation.bsb_aws_architect_role.result)["arn"]
    tags = var.tags
}
