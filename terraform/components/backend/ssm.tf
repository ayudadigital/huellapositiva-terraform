locals {
  base_path = "/config/backend_${var.environment}"
}

module no_reply_email {
  source = "../..//modules/ssm/parameter-from-encrypted"
  environment = var.environment
  region = var.region
  name = "${local.base_path}/${var.project["name"]}.feature.email.from"
  encrypted_value = var.no_reply_email_address
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
  value = var.datasource_url != "" ? var.datasource_url : "jdbc:postgresql://${data.terraform_remote_state.rds.outputs.endpoint}/${data.terraform_remote_state.rds.outputs.db_name}"
  state_bucket_name = var.state_bucket_name
}

module datasource_driver {
  source = "../..//modules/ssm/parameter"
  environment = var.environment
  region = var.region
  name = "${local.base_path}/spring.datasource.driverClassName"
  value = var.datasource_driver
  state_bucket_name = var.state_bucket_name
}

module datasource_dialect {
  source = "../..//modules/ssm/parameter"
  environment = var.environment
  region = var.region
  name = "${local.base_path}/spring.jpa.database-platform"
  value = var.datasource_dialect
  state_bucket_name = var.state_bucket_name
}

module datasource_username_random {
  count = var.datasource_url != "" ? 1 : 0
  source = "../..//modules/ssm/random-parameter"
  environment = var.environment
  region = var.region
  override_special = "!#$%&*()-_=+[]{}<>:?"
  name = "${local.base_path}/spring.datasource.username"
  state_bucket_name = var.state_bucket_name
}

module datasource_password_random {
  count = var.datasource_url != "" ? 1 : 0
  source = "../..//modules/ssm/random-parameter"
  environment = var.environment
  region = var.region
  override_special = "!#$%&*()-_=+[]{}<>:?"
  name = "${local.base_path}/spring.datasource.password"
  state_bucket_name = var.state_bucket_name
}

module datasource_username_rds {
  count = var.datasource_url != "" ? 0 : 1
  source = "../..//modules/ssm/parameter"
  environment = var.environment
  region = var.region
  name = "${local.base_path}/spring.datasource.username"
  value = data.terraform_remote_state.rds.outputs.db_user
  state_bucket_name = var.state_bucket_name
}

module datasource_password_rds {
  count = var.datasource_url != "" ? 0 : 1
  source = "../..//modules/ssm/parameter"
  environment = var.environment
  region = var.region
  name = "${local.base_path}/spring.datasource.password"
  value = data.terraform_remote_state.rds.outputs.db_pass
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
