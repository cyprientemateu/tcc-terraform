aws_region             = "us-east-1"
ami                    = "ami-0c7217cdde317cfec"
instance_type          = "t2.micro"
key_name               = "terraform"
vpc_security_group_ids = []
vpc_id                 = "vpc-091d07d5b426c38fb"
subnet_id              = "subnet-07fe2c2c1ed470cc7"
volume_size            = "10"
tags = {
  "id"             = "1119"
  "owner"          = "TCC"
  "teams"          = "Devops"
  "environment"    = "development"
  "project"        = "a3"
  "create_by"      = "Terraform"
  "cloud_provider" = "aws"
}

backend = {
  bucket         = ""
  dynamodb_table = ""
  key            = ""
  region         = ""
}