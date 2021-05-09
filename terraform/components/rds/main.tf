terraform {
  backend "s3" {}
}

provider aws {
  region = var.region
}

resource aws_db_subnet_group db_subnet_group {
  name       = "${var.environment}-rds"
  subnet_ids = data.terraform_remote_state.vpc.outputs.public_subnet_ids

  tags = {
    Name = "${var.environment}-rds"
    Environment = var.environment
    Project = var.project["name"]
  }
}

resource aws_security_group db_security_group {
  vpc_id = data.terraform_remote_state.vpc.outputs.id
  name = "${var.environment}-rds-sg"
  description = "RDS security group"

  tags = {
    Name = "${var.environment}-ecs-sg"
    Environment = var.environment
    Project = var.project["name"]
  }

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource aws_db_instance db {
  identifier             = "${var.environment}-rds"
  instance_class         = var.instance_type
  allocated_storage      = var.initial_size_gb
  max_allocated_storage  = var.max_size_gb
  multi_az               = var.multi_az_enabled
//  replicate_source_db    = "${var.environment}-rds"
  engine                 = "postgres"
  engine_version         = "13.1"
  name                   = var.database_name
  username               = random_password.db_username.result
  password               = random_password.db_password.result
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [ aws_security_group.db_security_group.id ]
  parameter_group_name   = aws_db_parameter_group.db_parameter_group.name
  publicly_accessible    = false
  skip_final_snapshot    = true
  deletion_protection    = var.delete_protection
  kms_key_id             = data.terraform_remote_state.kms.outputs.env_kms_key_arn
  storage_encrypted      = true
  backup_retention_period = var.backup_retention_period
  backup_window          = var.backup_window
  maintenance_window     = var.maintenance_window
  apply_immediately      = true
}

resource aws_db_parameter_group db_parameter_group {
  name   = "${var.environment}-rds"
  family = "postgres13"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource random_password db_username {
  length = 16
  special = false
  number = true
}

resource random_password db_password {
  length = 16
  special = true
  number = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
