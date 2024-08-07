variable "region" {
    type = string
    description = "AWS Region"
}

variable "account_id" {
    type = string
    description = "Target AWS account id"
}

variable "account" {
    type = string
    description = "Target account name"
}

variable "vpc" {
    type = string
    description = "Target VPC"
}

variable "sys_name" {
    type = string
    description = "System Name"
}

variable "ec2_instances" {
    type = any
    description = "Configuration information for EC2 instances that make up the System"
}

variable "sec_groups" {
    type = map(any)
    description = "Security Groups to be used by application instances"
}

variable "tags" {
    type = map(any)
    description = "Optional map of tags to set on resources, defaults to empty map"
}