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
  vpc_id                 = "vpc-091d07d5b426c38fb"
  vpc_cidr               = "10.0.0.0/16"
  public_subnet_cidrs    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs   = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones     = ["us-east-1a", "us-east-1b", "us-east-1c"]
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t2.micro"
  key_name               = "terraform"
  vpc_security_group_ids = ["sg-06b06755d07bcddd4"]
  subnet_id              = "subnet-07fe2c2c1ed470cc7"
  # subnet_id   = module.vpc.vpc_id
  volume_size = "10"
  tags = {
    "id"             = "1119"
    "owner"          = "TCC"
    "teams"          = "Devops"
    "environment"    = "development"
    "project"        = "a1"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
  cluster_identifier = "tcc-aurora-postgres-cluster"
  engine             = "aurora-postgresql"
  engine_version     = "11.9"
  database_name      = "tcyprien"
  master_username    = "carlos"
  # master_password    = 
  # db_subnet_group_name         = var.db_subnet_group_name
  # vpc_security_group_ids       = [var.vpc_security_group_ids]
  # db_subnet_group_name = module.vpc.private_subnet_ids
  # vpc_security_group_ids       = module.vpc.vpc_id
  skip_final_snapshot          = true
  backup_retention_period      = 7
  preferred_backup_window      = "02:00-03:00"
  preferred_maintenance_window = "sat:06:00-sat:07:00"
  storage_encrypted            = true
  name                         = "tcc_sg"
  length                       = 16
  special                      = true
  # vpc_id                       = module.vpc.vpc_id
  # Block for s3
  s3_versioning = "Enabled"
  random_s3 = {
    special = false
    upper   = false
    numeric = true
  }
}

# module "vpc" {
#   source               = "../../../modules/DEV/vpc"
#   aws_region           = local.aws_region
#   vpc_name             = local.vpc_name
#   vpc_cidr             = local.vpc_cidr
#   public_subnet_cidrs  = local.public_subnet_cidrs
#   private_subnet_cidrs = local.private_subnet_cidrs
#   availability_zones   = local.availability_zones

#   backend = {
#     bucket         = ""
#     dynamodb_table = ""
#     key            = ""
#     region         = ""
#   }
# }

module "ec2" {
  # source = "../../modules/QA/ec2-01"
  source                 = "../../modules/DEV/ec2"
  aws_region             = local.aws_region
  ami                    = local.ami
  instance_type          = local.instance_type
  key_name               = local.key_name
  vpc_security_group_ids = local.vpc_security_group_ids
  subnet_id              = local.subnet_id
  volume_size            = local.volume_size
  tags                   = local.tags
}

# module "s3" {
#   source     = "../../modules/DEV/s3"
#   aws_region = local.aws_region
#   random_s3 = {
#     special = false
#     upper   = false
#     numeric = true
#   }
#   # s3_versioning = {

#   # }
# }

module "s3" {
  source        = "../../modules/DEV/s3"
  random_s3     = local.random_s3
  s3_versioning = local.s3_versioning
}

module "db" {
  source = "../../modules/DEV/db"
  vpc_id = local.vpc_id
}