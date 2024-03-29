variable region {}

variable environment {}

variable state_bucket_name {}

variable project {
  type = map(string)
}

variable reviser_email {}

variable datasource_url {
  default = ""
}

variable datasource_driver {}

variable datasource_dialect {}

variable no_reply_email_address {}

variable cpu {}

variable memory {}

variable docker_image {}

variable hostname {}

variable ecs_task_initial_desired_count {}

variable ingress_cidr {
  default = ""
}

variable cloudwatch_logs_enabled {
  default = false
}
