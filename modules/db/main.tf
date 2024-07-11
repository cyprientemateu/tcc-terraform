resource "aws_db_subnet_group" "tcc_rds_subnet_group" {
  name       = format("tcc-rds-subnet-group-%s-%s-%s", var.tags["id"], var.tags[environment], var.tags["project"])
  subnet_ids = var.subnet_ids
  tags = merge(var.tags, {
    Name = format("%s-%s-%s-tcc-rds-subnet-group", var.tags["id"], var.tags["environment"], var.tags["project"])
    },
  )
}

resource "aws_security_group" "tcc_rds_sg" {
  name        = format("tcc-rds-sg-%s-%s-%s", var.tags["id"], var.tags[environment], var.tags["project"])
  description = "Example Security Group for Aurora PostgreSQL"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = format("%s-%s-%s-tcc-rds-sg", var.tags["id"], var.tags["environment"], var.tags["project"])
    },
  )
}

resource "aws_rds_cluster_parameter_group" "tcc-rds-cluster-parameter-group" {
  name        = format("tcc-rds-cluster-parameter-group-%s-%s-%s", var.tags["id"], var.tags[environment], var.tags["project"])
  family      = var.cluster_family
  description = format("tcc-rds-cluster-parameter-group-%s-%s-%s", var.tags["id"], var.tags[environment], var.tags["project"])
}

resource "aws_rds_cluster" "tcc_db_cluster" {
  cluster_identifier      = format("pg-%s-%s-%s-${var.database_name}-cluster", var.tags["id"], var.tags["environment"], var.tags["project"])
  engine                  = var.engine
  engine_version          = var.engine_version
  availability_zones      = var.avalability_zones
  database_name           = var.database_name
  master_username         = local.tcc-db-creds.master_username
  master_password         = local.tcc-db-creds.master_password
  db_subnet_group_name    = aws_db_subnet_group.tcc_rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.tcc_rds_sg.id]
  skip_final_snapshot     = true
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  deletion_protection     = false
  storage_encrypted       = true
  tags = {
    Name = format("%s-%s-%s-${var.database_name}-cluster", var.tags["id"], var.tags["environment"], var.tags["project"])
  }
}

resource "aws_rds_cluster_instance" "tcc_db_instances" {
  count                = var.instance_count
  cluster_identifier   = aws_rds_cluster.tcc_db_cluster.id
  instance_class       = var.instance_class
  engine               = var.engine
  engine_version       = var.engine_version
  publicly_accessible  = var.publicly_accessible
  db_subnet_group_name = aws_db_subnet_group.tcc_rds_subnet_group.name
  identifier           = "${var.database_name}-${count.index + 1}"
  lifecycle {
    ignore_changes = [
      engine_version
    ]
  }
  tags = {
    Name = "${var.database_name}-${count.index + 1}"
  }
}

resource "aws_route53_record" "cluster-alias" {
  zone_id = "Z02628573J1LNVJ1YWLC4"
  name    = "artifactory"
  type    = "CNAME"
  ttl     = "30"
  records = [aws_rds_cluster.tcc_db_cluster.endpoint]
}

output "cluster-master-password" {
  value     = aws_rds_cluster.tcc_db_cluster.master_password
  sensitive = true
}

output "cluster-kms-key-id" {
  value = aws_rds_cluster.tcc_db_cluster.kms_key_id
}