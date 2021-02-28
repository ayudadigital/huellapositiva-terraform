resource random_password value {
  length = var.length
  special = var.special
  number = var.number
  override_special = var.override_special
}

module ssm_parameter {
  source = "../parameter"
  environment = var.environment
  region = var.region
  name = var.name
  value = random_password.value.result
  state_bucket_name = var.state_bucket_name
}

output value {
  value = random_password.value.result
}