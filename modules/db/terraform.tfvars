aws_region = "us-east-1"

vpc_id                  = "vpc-091d07d5b426c38fb"
subnet_ids              = ["subnet-041d1a47d7aedefbb", "subnet-0b2a827b02d5c940e"]
avalability_zones       = ["us-east-1a", "us-east-1b"]
instance_count          = 2
instance_class          = "db.r5.large"
engine_version          = "11.9"
backup_retention_period = 7
preferred_backup_window = "02:00-03:00"

backend = {
  bucket         = ""
  dynamodb_table = ""
  key            = ""
  region         = ""
}