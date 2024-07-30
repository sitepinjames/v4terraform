# store the terraform state file in s3
terraform {
  backend "s3" {
    bucket  = "terrastatefilezidmer"
    key     = "3tiers.tfstate"
    region  = "us-east-1"
    profile = "terraform-usr"
  }
}
