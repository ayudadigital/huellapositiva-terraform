resource aws_ssm_parameter ssm_parameter {
  name = var.name
  type = "SecureString"
  value = var.value
  key_id = data.terraform_remote_state.kms.outputs.env_kms_key_arn
}
