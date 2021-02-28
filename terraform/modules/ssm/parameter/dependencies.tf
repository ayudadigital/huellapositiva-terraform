data terraform_remote_state kms {
  backend = "s3"
  config = {
    bucket = var.state_bucket_name
    key = "env-${var.environment}/infra/kms/${var.region}/terraform.tfstate"
    region = var.region
  }
}
