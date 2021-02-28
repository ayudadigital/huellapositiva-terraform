terraform {
  source = "../../../../../..//components/backend"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  cpu = 1024
  memory = 512
  docker_image = "ayudadigital/huelladigital-backend:133"
  ecs_task_initial_desired_count = 0
  ingress_cidr = "0.0.0.0/0"

  // ================================================
  // ============ Application properties ============
  // ================================================
  datasource_url = "jdbc:h2:mem:testdb"
  reviser_email = "admin@ayudadigital.org"
  no_reply_email_address = "huellapositiva@outlook.com"
  testy_enc = "AQICAHjd5nY0VxoK7mgJ8W+HiU5qBVqEds5Zu8R0WDwoxGOzDAGf6Ho3zUo98kp1dkjjk0j1AAAAZDBiBgkqhkiG9w0BBwagVTBTAgEAME4GCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMP3bipP1MKn+6mduNAgEQgCF3ZZYbBvEWJtbVYjFsyysQgYWQlZS5y/Sd5X1Z7Jsw+oY="
}
