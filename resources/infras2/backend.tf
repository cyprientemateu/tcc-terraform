terraform {
  backend "s3" {
    bucket         = "cyprienbucket"
    dynamodb_table = "terraform-lock"
    key            = "INFRAS2/terraform.tfstate"
    region         = "us-east-1"
  }
}