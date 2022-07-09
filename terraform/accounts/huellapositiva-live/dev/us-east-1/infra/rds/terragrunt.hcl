terraform {
  source = "../../../../../../components/rds"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  database_name = "huellapositiva_dev"
  backup_retention_period = 7
}
