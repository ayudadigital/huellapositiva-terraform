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
  ecs_task_initial_desired_count = 1
//  ingress_cidr = "0.0.0.0/0"

  // ================================================
  // ============ Application properties ============
  // ================================================
  datasource_url = "jdbc:h2:mem:testdb"
  reviser_email = "AQICAHgH0cctO3uXC5n3FlzZ17pYxzUUERtkeR++L4/O5zWn3QEPcrPM+MhpajkK7S7GDfRLAAAAdDByBgkqhkiG9w0BBwagZTBjAgEAMF4GCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMPDZzlo2w4a+BMjPLAgEQgDHmnfPwII+mqCu8+DC2LpeICjN8iSbomRfkrulzCPmpQ6G0JIQG58HaVTPCthv4vxqg"
  no_reply_email_address = "no-reply@ayudadigital.org"
}
