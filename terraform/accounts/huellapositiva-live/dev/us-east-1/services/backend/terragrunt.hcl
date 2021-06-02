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
  datasource_driver = "org.h2.Driver"
  datasource_dialect = "org.hibernate.dialect.H2Dialect"
  reviser_email = "AQICAHi1jLPwusPhY7SOrNiDPPPFlJis6F7E6M6MbSTVUBbyMwEHWJWpnA0PU29izUR1UqQDAAAAdDByBgkqhkiG9w0BBwagZTBjAgEAMF4GCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMltfLruqmEYiBV9sJAgEQgDFCey2Ca/JB/h95ExTUONPQEhaLuNbZe+E98X9W7fPxWlbC+wu1D/Nd1W75h/2dNjRJ"
  no_reply_email_address = "AQICAHgH0cctO3uXC5n3FlzZ17pYxzUUERtkeR++L4/O5zWn3QFK1EZ0t7LMCpTefsv0WGKiAAAAezB5BgkqhkiG9w0BBwagbDBqAgEAMGUGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMBGxoFWfCj4/cD+liAgEQgDjAKxwAVCKntIIf5VFHrhPMb3PXNV34CbT18R1iaNdG9ypDMf2dp+hcjeL8xFp04Tx1PJRAPWM3Gg=="
}
