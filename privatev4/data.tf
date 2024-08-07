# Data Function Calls

# Network Data
data "aws_vpc" "this" {
    tags = {
        Name = var.vpc
    }
}

data "aws_subnet" "ec2_instance" {
    for_each = var.ec2_instance

    cidr_block = each.value["ec2_subnet"]
}

data "aws_caller_identity" "caller" {}

data "aws_ec2_managed_prefix_list" "akamai" {
    filter {
        name = "prefix-list-name"
        values = ["akamai-ip-prefix-list"]
    }
}

data "aws_security_group" "bsb_linuxops_management" {
    filter {
        name = "tag:Name"
        values = ["linuxops-management-${data.aws_vpc.this.tags["Name"]}-sg"]
    }
}

data "aws_security_group" "bsb_linuxops_internet" {
    filter {
        name = "tag:Name"
        values = ["linuxops-internet-${data.aws_vpc.this.tags["Name"]}-sg"]
    }
}

data "aws_lambda_invocation" "bsb_aws_architect_role" {
    function_name = "sso-tf-roles"
    input = jsonencode(
        { "method" : "get",
            "account_number" : data.aws_caller_identity.current_id,
        "role" : "BSB_AWS_Architects"}
    )
}

data "aws_iam_policy" "ssm_managed" {
    name = "AmazonSSMManagedInstanceCore"
}

data "aws_ami" "bsb_ami" {
    for_each = var.ec2_instances

    most_recent = true
    owners = [each.value["ami_owner"]]

    filter{
        name = "name"
        values = [each.value["ami_filter"]]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}