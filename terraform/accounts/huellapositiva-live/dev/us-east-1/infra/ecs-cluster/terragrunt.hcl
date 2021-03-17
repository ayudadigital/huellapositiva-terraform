terraform {
  source = "../../../../../../components/ecs-cluster"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  ec2_instance_type = "t3a.micro"
  ecs_min_instances = 0
  ecs_max_instances = 2
  ecs_desired_instances = 1
  scheduled_scaling = {
    enabled = 1
    scale_down_cron_utc = "0 20 * * 1-5"
    scale_up_cron_utc = "0 8 * * 1-5"
  }
  spot_instance_max_price = "0.0050"
}