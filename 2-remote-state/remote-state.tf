provider "aws" {
  profile = "default"
  region  = "us-west-2"
  version = "3.4"
}

resource "aws_s3_bucket" "s3_bucket" {
  acl           = "private"
  bucket        = "psharma-van-bucket"
  force_destroy = true
  versioning {
    enabled = true
  }
  tags = {
    DeployedBy = local.user_id
  }
}

resource "aws_dynamodb_table" "dynamodb_table_tf_state_lock" {
  name           = "psharma-van-lock"
  hash_key       = "LockID"
  read_capacity  = 5
  write_capacity = 5
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    DeployedBy = local.user_id
  }
}
