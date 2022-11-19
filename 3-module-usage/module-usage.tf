provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

module "db" {
  source = "git@git.dapt.to:vanguard/terraform/tf-module-db.git"

  # Change the value for deployment name to one which suits you
  deployment_name = "${local.user_id}-db-dont-keep"
  business_unit   = "your-business"
  deployment_tag  = "multi-rds"
  project_tag     = "your-project"
  team            = "your-team"
  workload_type   = "non-cogs"

  # Security group parameters
  vpc_id             = "vpc-cb3ceeae"
  security_group_ids = null

  # Alerts parameters
  pager_duty_integration_key = ""

  # RDS instance parameters
  allocated_storage           = 5
  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = false
  backup_retention_days       = 0
  copy_tags_to_snapshot       = true
  deletion_protection         = false
  engine                      = "MySQL"
  engine_version              = "5.6.43"
  innodb_io_capacity          = "200"
  innodb_io_capacity_max      = "2000"
  innodb_lru_scan_depth       = "200"
  instance_class              = "db.t2.micro"
  instance_identifier_suffix  = ""
  iops                        = null
  kms_key_arn                 = ""
  max_allocated_storage       = 0
  multi_az                    = false
  password                    = "simplepassword"
  port                        = 3306
  publicly_accessible         = false
  skip_final_snapshot         = true
  snapshot_identifier         = ""
  storage_type                = "standard"
  subnet_ids                  = ["subnet-68a56c1f", "subnet-0439ab61"]
  tags = map(
    "DeployedBy", local.user_id
  )
}
