variable region {}

variable environment {}

variable state_bucket_name {}

variable service_name {}

variable hostname {}

variable application_port {}

variable alb_listener_rule_priority {}

variable ecs_task_initial_desired_count {}

variable cpu {}

variable memory {}

variable docker_image {}

variable alb_health_check_path {
  default = "/"
}

variable alb_path_patterns {
  type = list(string)
}

variable host_headers {
  type = list(string)
}

variable project {
  type = map(string)
}

variable service_policies {
  type = list(string)
  default = []
}

variable ingress_cidr {
  default = ""
}

variable service_env_variables {
  default = ""
}

variable cloudwatch_logs_enabled {
  default = false
}
