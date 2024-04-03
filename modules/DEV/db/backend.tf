terraform {
  backend "s3" {
    bucket         = "cyprienbucket"
    dynamodb_table = "terraform-lock"
    key            = "TCC/aurora-PostgreSQL-db/terraform.tfstate"
    region         = "us-east-1"
  }
}