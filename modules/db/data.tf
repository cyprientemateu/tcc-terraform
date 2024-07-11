data "aws_secretsmanager_secret_version" "database_password" {
  secret_id = "tcc-db-creds"
}

locals {
  tcc-db-creds = jsondecode(
    data.aws_secretsmanager_secret_version.database_password.secret_string
  )
}

# data "aws_vpc" "vpc_id" {
#   filter {
#     name   = "tag:Name"
#     values = ["	tcc-vpc"]
#   }
# }

# data "aws_subnet" "private_1" {
#   filter {
#     name   = "tag:Name"
#     values = ["tcc-vpc-private-subnet-1"]
#   }
# }

# data "aws_subnet" "private_2" {
#   filter {
#     name   = "tag:Name"
#     values = ["	tcc-vpc-private-subnet-2"]
#   }
# }