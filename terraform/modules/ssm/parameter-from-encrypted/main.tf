locals {
  secret_key = "secret-key"
}

data aws_kms_secrets decrypted_value {
  secret {
    name    = local.secret_key
    payload = var.encrypted_value
  }
}

module ssm_parameter {
  source = "../parameter"

  environment = var.environment
  region = var.region
  name = var.name
  value = data.aws_kms_secrets.decrypted_value.plaintext[local.secret_key]
  state_bucket_name = var.state_bucket_name
}