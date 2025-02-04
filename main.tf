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

# security_group output
output "security_group_id" {
  value = module.security_group.security_group_id
}

module "ec2" {
  source            = "./modules/ec2"
  ami               = "ami-07d9cf938edb0739b"
  instance_type     = "t2.micro"
  subnet_id         = module.vpc.public_subnets[0]
  security_group_id = module.security_group.security_group_id
  tags              = { Environment = "dev" }
  key_name          = "best_dir"
  allowed_ssh_cidrs = ["0.0.0.0/0"]
}

