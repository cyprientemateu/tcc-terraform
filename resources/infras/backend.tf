terraform {
  backend "s3" {
    bucket         = "cyprienbucket"
    dynamodb_table = "terraform-lock"
    key            = "INFRAS/terraform.tfstate"
    region         = "us-east-1"
  }
}