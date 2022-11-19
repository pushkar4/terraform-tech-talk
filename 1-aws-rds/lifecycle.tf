provider "aws" {
  profile = "default"
  region  = "us-west-2"
  version = "3.4"
}

provider "external" {
  version = "1.2"
}

terraform {
  backend "s3" {
    bucket         = "RENAME-bucket-dont-keep"
    dynamodb_table = "RENAME-lock-dont-keep"
    key            = "tf-db.tfstate"
    region         = "us-west-2"
  }
}

data "external" "user_id" {
  program = ["sh", "../scripts/fetch-value.sh", "user_id"]
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = "arn:aws:secretsmanager:us-west-2:01234567890:secret:van-psharma-secret-R492eV"
}

locals {
  user_id = data.external.user_id.result.response
}

resource "aws_security_group" "security_group" {
  name   = "${local.user_id}-sg-dont-keep"
  vpc_id = "vpc-cb3ceeae"
  tags = {
    DeployedBy = local.user_id
  }
  ingress {
    description = "My Mac/Linux inbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["YOUR-IP/32"] # Change this to "YOUR-IP/32"
  }
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${local.user_id}-subgrp-dont-keep"
  subnet_ids = ["subnet-0de29e897f1db4887", "subnet-54a56c23"]
  tags = {
    DeployedBy = local.user_id
  }
}

resource "aws_db_instance" "db_instance" {
  allow_major_version_upgrade = false
  allocated_storage           = var.allocated_storage
  auto_minor_version_upgrade  = false
  backup_retention_period     = 0
  copy_tags_to_snapshot       = true
  db_subnet_group_name        = aws_db_subnet_group.db_subnet_group.name
  deletion_protection         = false
  engine                      = "MySQL"
  engine_version              = "5.7.26"
  identifier                  = "${local.user_id}-db-dont-keep"
  instance_class              = var.instance_class
  multi_az                    = var.multi_az
  parameter_group_name        = "default.mysql5.7"
  port                        = 3306
  publicly_accessible         = true
  skip_final_snapshot         = var.skip_final_snapshot
  storage_type                = var.storage_type
  username                    = "admin"
  vpc_security_group_ids      = [aws_security_group.security_group.id]
  tags = {
    DeployedBy = local.user_id
  }
  password = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)["password"]
}
