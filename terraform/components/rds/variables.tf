variable project {
  type = map(string)
}

variable region {}

variable environment {}

variable state_bucket_name {}

variable database_name {}

variable delete_protection {
  default = false
}

variable multi_az_enabled {
  default = false
}

variable instance_type {
  default = "db.t3.micro"
}

variable initial_size_gb {
  default = 5
}

variable max_size_gb {
  default = 0
}

variable backup_retention_period {
  default = 0
}

variable backup_window {
  default = "01:00-02:00"
}

variable maintenance_window {
  default = "Mon:02:30-Mon:05:30"
}
