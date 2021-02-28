variable name {
  default = "ecs-cluster"
}

variable ec2_instance_type {}

variable ecs_min_instances {}
variable ecs_max_instances {}
variable ecs_desired_instances {}

variable project {
  type = map(string)
}

variable region {}

variable environment {}

variable state_bucket_name {}

variable scheduled_scaling {
  type = map(string)
}

variable spot_instance_max_price {
  description = "Maximum price ($/h) we allow to pay in order to allocate Spot instances"
  default = "0.0094" // Regular t3a.micro on demand EC2 instance price
}
