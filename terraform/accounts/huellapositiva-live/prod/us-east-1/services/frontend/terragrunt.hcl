terraform {
  source = "../../../../../..//components/frontend"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  cpu = 512
  memory = 512
  docker_image = "ayudadigital/huelladigital-frontend:199b97c15fbe5b977778b7f30bade0124e332dd9"
  ecs_task_initial_desired_count = 2
  cloudwatch_logs_enabled = false
}