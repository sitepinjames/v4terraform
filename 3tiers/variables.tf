variable "region" {}
variable "Environment" {}
variable "vpc_cidr" {}
variable "Subnet1_cidr" {}
variable "Subnet2_cidr" {}
variable "PrivAppSubnet1_cidr" {}
variable "PrivAppSubnet2_cidr" {}
variable "PrivDataSubnet1_cidr" {}
variable "PrivDataSubnet2_cidr" {}
variable "DeveloperCidr" {
  default = "108.31.122.8/32"
}
variable "ami_id" {}
variable "number_of_instances" {}
variable "instance_type" {}
variable "key_name" {}
