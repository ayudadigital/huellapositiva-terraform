terraform {
  backend "s3" {}
}

provider aws {
  region = var.region
}

module ecs_service {
  source = "../..//modules/ecs-service"
  alb_listener_rule_priority = 2
  alb_path_patterns = [ "/*" ]
  alb_health_check_path = "/"
  application_port = 5000
  cpu = var.cpu
  docker_image = var.docker_image
  ecs_task_initial_desired_count = var.ecs_task_initial_desired_count
  environment = var.environment
  host_headers = [ var.hostname ]
  hostname = var.hostname
  memory = var.memory
  project = var.project
  region = var.region
  service_name = "frontend"
  state_bucket_name = var.state_bucket_name
  ingress_cidr = var.ingress_cidr
  service_env_variables = <<EOT
  ,{
    "name" : "REACT_APP_BASE_URI",
    "value" : "https://${var.hostname}"
  },
  {
    "name" : "REACT_APP_BASE_API",
    "value" : "https://${var.hostname}"
  }
  EOT
}