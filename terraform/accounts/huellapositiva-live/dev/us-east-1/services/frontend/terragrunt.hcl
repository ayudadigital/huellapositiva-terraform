terraform {
  source = "../../../../../..//components/frontend"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  cpu = 512
  memory = 256
  docker_image = "ayudadigital/huelladigital-frontend:29"
  ecs_task_initial_desired_count = 1
//  ingress_cidr = "0.0.0.0/0"
}