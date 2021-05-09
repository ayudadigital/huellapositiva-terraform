output db_user {
  value = random_password.db_username.result
  sensitive = true
}

output db_pass {
  value = random_password.db_password.result
  sensitive = true
}

output address {
  value = aws_db_instance.db.address
}
