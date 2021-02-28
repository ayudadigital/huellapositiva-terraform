resource aws_iam_user developer {
  name = "${var.environment}-${var.project["name"]}-developer"
  path = "/system/"
}

resource aws_iam_access_key developer {
  user    = aws_iam_user.developer.name
  pgp_key = "keybase:huellapositiva"
}

resource aws_iam_user_policy_attachment ro {
  user       = aws_iam_user.developer.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource aws_iam_user_login_profile developer {
  user    = aws_iam_user.developer.name
  pgp_key = "keybase:huellapositiva"
  password_reset_required = false
}

output developer_username {
  value = aws_iam_user_login_profile.developer.user
}

output developer_password {
  value = aws_iam_user_login_profile.developer.encrypted_password
}

output developer_access_key_id {
  value = aws_iam_access_key.developer.id
}

output developer_access_key_secret {
  value = aws_iam_access_key.developer.encrypted_secret
}
