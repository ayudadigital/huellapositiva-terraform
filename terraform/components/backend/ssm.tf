locals {
  base_path = "/config/backend_${var.environment}"
}

module no_reply_email {
  source = "../..//modules/ssm/parameter"
  environment = var.environment
  region = var.region
  name = "${local.base_path}/${var.project["name"]}.feature.email.from"
  value = var.no_reply_email_address
  state_bucket_name = var.state_bucket_name
}

module reviser_email {
  source = "../..//modules/ssm/parameter-from-encrypted"
  environment = var.environment
  region = var.region
  name = "${local.base_path}/${var.project["name"]}.web-admin.email"
  encrypted_value = var.reviser_email
  state_bucket_name = var.state_bucket_name
}

module reviser_password {
  source = "../..//modules/ssm/random-parameter"
  environment = var.environment
  region = var.region
  override_special = "!#$%&*()-_=+[]{}<>:?"
  name = "${local.base_path}/${var.project["name"]}.web-admin.password"
  state_bucket_name = var.state_bucket_name
}

module datasource_url {
  source = "../..//modules/ssm/parameter"
  environment = var.environment
  region = var.region
  name = "${local.base_path}/spring.datasource.url"
  value = var.datasource_url
  state_bucket_name = var.state_bucket_name
}

module datasource_username {
  source = "../..//modules/ssm/random-parameter"
  environment = var.environment
  region = var.region
  override_special = "!#$%&*()-_=+[]{}<>:?"
  name = "${local.base_path}/spring.datasource.username"
  state_bucket_name = var.state_bucket_name
}

module datasource_password {
  source = "../..//modules/ssm/random-parameter"
  environment = var.environment
  region = var.region
  override_special = "!#$%&*()-_=+[]{}<>:?"
  name = "${local.base_path}/spring.datasource.password"
  state_bucket_name = var.state_bucket_name
}

module jwt_encryption_secret {
  source = "../..//modules/ssm/random-parameter"
  environment = var.environment
  region = var.region
  special = false
  length = 32
  name = "${local.base_path}/jwt.encryption.secret"
  state_bucket_name = var.state_bucket_name
}

module jwt_signature_secret {
  source = "../..//modules/ssm/random-parameter"
  environment = var.environment
  region = var.region
  special = false
  length = 64
  name = "${local.base_path}/jwt.signature.secret"
  state_bucket_name = var.state_bucket_name
}

module data_bucket {
  source = "../..//modules/ssm/parameter"
  environment = var.environment
  region = var.region
  name = "${local.base_path}/aws.s3.buckets.data"
  value = aws_s3_bucket.bucket_service_data.bucket
  state_bucket_name = var.state_bucket_name
}

module mgmt_bucket {
  source = "../..//modules/ssm/parameter"
  environment = var.environment
  region = var.region
  name = "${local.base_path}/aws.s3.buckets.mgmt"
  value = aws_s3_bucket.bucket_mgmt_data.bucket
  state_bucket_name = var.state_bucket_name
}
