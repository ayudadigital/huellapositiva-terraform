output db_user {
  value = random_password.db_username.result
  sensitive = true
}

output db_pass {
  value = random_password.db_password.result
  sensitive = true
}

output endpoint {
  value = aws_db_instance.db.endpoint
}

output db_name {
  value = aws_db_instance.db.name
}
