terraform {
  backend "s3" {}
}

provider aws {
  region = var.region
}

resource aws_kms_key env_key {
  description = "${var.project["name"]}-${var.environment} default KMS key"
  enable_key_rotation = true

  tags = {
    Name = "${var.project["name"]}-${var.environment}-kms-key"
    Environment = var.environment
    Project = var.project["name"]
  }
}

resource aws_kms_alias env_key_alias {
  name          = "alias/${var.project["name"]}-${var.environment}-kms-key-alias"
  target_key_id = aws_kms_key.env_key.key_id
}
