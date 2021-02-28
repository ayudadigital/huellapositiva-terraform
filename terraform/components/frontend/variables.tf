variable region {}

variable environment {}

variable state_bucket_name {}

variable project {
  type = map(string)
}

variable cpu {}

variable memory {}

variable docker_image {}

variable hostname {}

variable ecs_task_initial_desired_count {}

variable ingress_cidr {
  default = ""
}