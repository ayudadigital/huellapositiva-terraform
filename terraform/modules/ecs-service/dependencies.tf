data terraform_remote_state vpc {
  backend = "s3"
  config = {
    bucket = var.state_bucket_name
    key = "env-${var.environment}/infra/vpc/${var.region}/terraform.tfstate"
    region = var.region
  }
}

data terraform_remote_state ecs {
  backend = "s3"
  config = {
    bucket = var.state_bucket_name
    key = "env-${var.environment}/infra/ecs-cluster/${var.region}/terraform.tfstate"
    region = var.region
  }
}

data terraform_remote_state load-balancer {
  backend = "s3"
  config = {
    bucket = var.state_bucket_name
    key = "env-${var.environment}/infra/load-balancer/${var.region}/terraform.tfstate"
    region = var.region
  }
}
