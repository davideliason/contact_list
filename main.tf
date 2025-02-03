terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# configure the aws provider
provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "vscodeaws"
  region                   = "us-west-2"
}


module "vpc" {
  source          = "./modules/vpc"
  vpc_name        = "contact-list-vpc"
  cidr            = "10.16.0.0/16"
  azs             = ["us-west-2a", "us-west-2b"]
  public_subnets  = ["10.16.0.0/20", "10.16.16.0/20"]
  private_subnets = ["10.16.32.0/20", "10.16.48.0/20"]
  tags = {
    Environment = "dev"
    Project     = "contact-list"
  }
}

module "security_group" {
  source = "./modules/security-group"
  name   = "contact-list-sg"
  vpc_id = module.vpc.vpc_id
  tags   = { Environment = "dev" }
}
