aws_region           = "us-east-1"
vpc_name             = "tcc-vpc"
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b", "us-east-1c"]

backend = {
  bucket         = "1119-a1-main-backend"
  dynamodb_table = "dynamodb-tcc-1119"
  key            = "vpc/terraform.statefile"
  region         = "us-east-1"
  encript        = true
}
