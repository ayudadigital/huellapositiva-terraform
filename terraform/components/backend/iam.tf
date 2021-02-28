data template_file s3_service_policy {
  template = file("${path.module}/iam_policy_s3_service.tpl")

  vars = {
    bucket_data_arn = aws_s3_bucket.bucket_service_data.arn
    bucket_mgmt_data_arn = aws_s3_bucket.bucket_mgmt_data.arn
    kms_env_key = data.terraform_remote_state.kms.outputs.env_kms_key_arn
  }
}

resource aws_iam_policy s3_service_policy {
  name = "${var.project["name"]}-${var.environment}-s3-backend-service"
  path = "/${var.project["name"]}/${var.environment}/s3/"
  policy = data.template_file.s3_service_policy.rendered
}

data template_file s3_manager_policy {
  template = file("${path.module}/iam_policy_s3_manager.tpl")

  vars = {
    bucket_mgmt_data_arn = aws_s3_bucket.bucket_mgmt_data.arn
    kms_env_key = data.terraform_remote_state.kms.outputs.env_kms_key_arn
  }
}

resource aws_iam_policy s3_manager_policy {
  name = "${var.project["name"]}-${var.environment}-s3-backend-manager"
  path = "/${var.project["name"]}/${var.environment}/s3/"
  policy = data.template_file.s3_manager_policy.rendered
}

data template_file ses_service_policy {
  template = file("${path.module}/iam_policy_ses_service.tpl")

  vars = {
    noreply_email_arn = aws_ses_email_identity.no_reply_email.arn
  }
}

resource aws_iam_policy ses_service_policy {
  name = "${var.project["name"]}-${var.environment}-ses-backend-service"
  path = "/${var.project["name"]}/${var.environment}/ses/"
  policy = data.template_file.ses_service_policy.rendered
}
