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
    scale_down_cron_utc = "0 20 * * *"
    scale_up_cron_utc = "0 8 * * *"
  }
  spot_instance_max_price = "0.0050"
  ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDWNJj+gScwRI+wnJKW0TXZvZGPQ03Omx/UoGbcqAcMkAwP0koFhvWNY5HyOoBORp68GpJ/e6N9YQvgGK+V0JgIoF2XkWDpDQZTFlDeiD6unEJ+hmnwY7EToNkPPxo++IRoP3vst5JuEsizehk7s6YU5roZJrUi0KdDPSLzQ0pW0AEPV7Im2rijS4wb0PFOhLBpOnIXXuQ2xKgpaA3hdHW8hpmgwzjf/sEWri9pv00X9gfXG+JAhKHwpv0I/yG+Gh7GdCpoJM7oyYVBMusxjRaIb7xaMM+2tRgTr++4LbwOcBeez1X9Od1W4Pl3djPtU30+mh2Xf0kM8t5wHRKEp/hkThrFSWCv1j3yFww7+ZTJ5q5uDX0DZAhhRO0CQ7c586Bqk8dHkSqP8pvNEQRTOkS/ve2yVobpN3ogAfNkpdEMJZFiXH23tR/wPNbLK3Q2WdU6pJZVPcnN5LLfZpVAtcGIXacwubfaKuyPNda/9OpSca8RN2qBunRKmJ/8E3LCfNc="
}