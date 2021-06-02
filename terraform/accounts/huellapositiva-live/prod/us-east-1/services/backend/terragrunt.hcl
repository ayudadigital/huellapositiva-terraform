terraform {
  source = "../../../../../..//components/backend"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  cpu = 1024
  memory = 1024
  docker_image = "ayudadigital/huelladigital-backend:651de4862cacd43d8e4b45c2dd9d770e0d94e415"
  ecs_task_initial_desired_count = 2
  cloudwatch_logs_enabled = false

  // ================================================
  // ============ Application properties ============
  // ================================================
  datasource_driver = "org.postgresql.Driver"
  datasource_dialect = "org.hibernate.dialect.PostgreSQL10Dialect"
  reviser_email = "set-encrypted-value"
  no_reply_email_address = "set-encrypted-value"
}
