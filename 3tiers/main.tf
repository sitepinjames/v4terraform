# Configure aws provider
provider "aws" {
  region = var.region
}
#create vpc
module "vpc_module" {
  source               = "../Modules/VPC"
  region               = var.region
  Environment          = var.Environment
  vpc_cidr             = var.vpc_cidr
  Subnet1_cidr         = var.Subnet1_cidr
  Subnet2_cidr         = var.Subnet2_cidr
  PrivAppSubnet1_cidr  = var.PrivAppSubnet1_cidr
  PrivAppSubnet2_cidr  = var.PrivAppSubnet2_cidr
  PrivDataSubnet1_cidr = var.PrivDataSubnet1_cidr
  PrivDataSubnet2_cidr = var.PrivDataSubnet2_cidr

}
module "Sec-Group-Module" {
  source        = "../Modules/Security-Group"
  DeveloperCidr = var.DeveloperCidr
  Environment   = var.Environment
  myvpc_id      = module.vpc_module.myvpc_id
}
module "EC2-Module" {
  source              = "../Modules/EC2"
  PubSubnet_id        = module.vpc_module.PubSubnet_id
  number_of_instances = var.number_of_instances
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  key_name            = var.key_name
}
output "EnvironmentName" {
  value = module.vpc_module.Environment
}
output "Sec-Grp_id" {
  value = module.Sec-Group-Module.Sec-Grp_id
}
