terraform {
  source = "../../../../../../components/rds"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  database_name = "huellapositiva_prod"
  backup_retention_period = 7
  delete_protection = true
  instance_type = "db.t3.micro"
}
