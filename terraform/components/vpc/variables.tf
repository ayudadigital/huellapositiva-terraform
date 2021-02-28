variable region {
  type        = string
  description = "Region of the VPC"
}

variable project {
  type = map(string)

  default = {
    name = "huellapositiva"
  }
}

variable environment {}

variable availability_zones {
  type = list(string)
  default = []
}

variable vpc_config {
  type = map(string)
  default = {}
}
