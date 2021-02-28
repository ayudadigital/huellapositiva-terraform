output env_kms_key_arn {
  value = aws_kms_key.env_key.arn
}

output env_kms_key_alias_name {
  value = aws_kms_alias.env_key_alias.name
}
