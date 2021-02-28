data terraform_remote_state ecs {
  backend = "s3"
  config = {
    bucket = var.state_bucket_name
    key = "env-${var.environment}/infra/ecs-cluster/${var.region}/terraform.tfstate"
    region = var.region
  }
}
