resource aws_s3_bucket bucket_service_data {
  bucket = "${var.project["name"]}-${var.environment}-backend-data"
  acl    = "private"

  tags = {
    Name = "${var.project["name"]}-${var.environment}-backend-data"
    Environment = var.environment
    Project = var.project["name"]
  }
}

resource aws_s3_bucket bucket_mgmt_data {
  bucket = "${var.project["name"]}-${var.environment}-backend-mgmt-data"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = data.terraform_remote_state.kms.outputs.env_kms_key_arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = {
    Name = "${var.project["name"]}-${var.environment}-backend-mgmt-data"
    Environment = var.environment
    Project = var.project["name"]
  }
}