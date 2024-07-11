terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = local.aws_region
}

locals {
  aws_region             = "us-east-1"
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t2.micro"
  key_name               = "terraform"
  vpc_security_group_ids = ["sg-0fa88e0bcf2d36083"]
  subnet_id              = "subnet-02e286c9bdfb33f0b"
  volume_size            = "10"
  tags = {
    "id"             = "1119"
    "owner"          = "TCC"
    "teams"          = "Devops"
    "environment"    = "development"
    "project"        = "a1"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
  random_s3 = {
    special = false
    upper   = false
    numeric = true
  }

  s3_versioning = "Enabled"
}

module "ec2" {
  source                 = "../../modules/ec2"
  aws_region             = local.aws_region
  ami                    = local.ami
  instance_type          = local.instance_type
  key_name               = local.key_name
  vpc_security_group_ids = local.vpc_security_group_ids
  subnet_id              = local.subnet_id
  volume_size            = local.volume_size
  tags                   = local.tags
}

module "s3" {
  source = "../../modules/s3"
  #   region        = local.aws_region
  random_s3     = local.random_s3
  s3_versioning = local.s3_versioning

}