locals {
  secret_key = "secret-key"
}

data aws_kms_secrets no_reply_email {
  secret {
    name    = local.secret_key
    payload = var.no_reply_email_address
  }
}

resource aws_ses_email_identity no_reply_email {
  email = data.aws_kms_secrets.no_reply_email.plaintext[local.secret_key]
}
