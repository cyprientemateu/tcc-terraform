terraform {
  backend "s3" {
    bucket         = "cyprienbucket"
    dynamodb_table = "terraform-lock"
    key            = "TCC/ec2/terraform.tfstate"
    region         = "us-east-1"
  }
}