terraform {
  backend "s3" {}
}

provider aws {
  region = var.region
}

module ecs_service {
  source = "../..//modules/ecs-service"
  alb_listener_rule_priority = 1
  alb_path_patterns = [
    "/actuator/*",
    "/api/*",
    "/swagger-ui/*",
    "/v3/api-docs/*"
  ]
  alb_health_check_path = "/actuator/health"
  application_port = 8080
  cpu = var.cpu
  docker_image = var.docker_image
  ecs_task_initial_desired_count = var.ecs_task_initial_desired_count
  environment = var.environment
  host_headers = [ var.hostname ]
  hostname = var.hostname
  memory = var.memory
  project = var.project
  region = var.region
  service_name = "backend"
  state_bucket_name = var.state_bucket_name
  ingress_cidr = var.ingress_cidr
  service_policies = list(
          aws_iam_policy.s3_service_policy.arn,
          aws_iam_policy.ses_service_policy.arn,
          "arn:aws:iam::aws:policy/AmazonSSMFullAccess" // TODO Limit
  )
}