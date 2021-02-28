resource aws_launch_configuration launch_configuration {
  instance_type = var.ec2_instance_type
  image_id = "ami-0f06fc190dd71269e"
  spot_price = var.spot_instance_max_price
  iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
  user_data = data.template_file.user_data.rendered
  key_name = aws_key_pair.maintainer.key_name
  security_groups = [
    aws_security_group.ecs_security_group.id
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource aws_key_pair maintainer {
  key_name   = "huellapositiva_dev"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDWNJj+gScwRI+wnJKW0TXZvZGPQ03Omx/UoGbcqAcMkAwP0koFhvWNY5HyOoBORp68GpJ/e6N9YQvgGK+V0JgIoF2XkWDpDQZTFlDeiD6unEJ+hmnwY7EToNkPPxo++IRoP3vst5JuEsizehk7s6YU5roZJrUi0KdDPSLzQ0pW0AEPV7Im2rijS4wb0PFOhLBpOnIXXuQ2xKgpaA3hdHW8hpmgwzjf/sEWri9pv00X9gfXG+JAhKHwpv0I/yG+Gh7GdCpoJM7oyYVBMusxjRaIb7xaMM+2tRgTr++4LbwOcBeez1X9Od1W4Pl3djPtU30+mh2Xf0kM8t5wHRKEp/hkThrFSWCv1j3yFww7+ZTJ5q5uDX0DZAhhRO0CQ7c586Bqk8dHkSqP8pvNEQRTOkS/ve2yVobpN3ogAfNkpdEMJZFiXH23tR/wPNbLK3Q2WdU6pJZVPcnN5LLfZpVAtcGIXacwubfaKuyPNda/9OpSca8RN2qBunRKmJ/8E3LCfNc= admin@ayudadigital.org"
}

data template_file user_data {
  template = file("${path.module}/autoscaling_user_data.tpl")
  vars = {
    ECS_CLUSTER = aws_ecs_cluster.ecs_cluster.name
  }
}

resource aws_autoscaling_group auto_scaling_group {
  name = "${aws_ecs_cluster.ecs_cluster.name}-asg"
  max_size = var.ecs_max_instances
  min_size = var.ecs_min_instances
  desired_capacity = var.ecs_desired_instances
  health_check_grace_period = 300
  health_check_type = "EC2"
  force_delete = true
  launch_configuration = aws_launch_configuration.launch_configuration.name
  vpc_zone_identifier = compact(split(",", join(",", data.terraform_remote_state.vpc.outputs.public_subnet_ids)))

  tags = list(
           map("key", "Name", "value", "${aws_ecs_cluster.ecs_cluster.name}-asg-instance", "propagate_at_launch", true),
           map("key", "Environment", "value", var.environment, "propagate_at_launch", true),
           map("key", "Project", "value", var.project["name"], "propagate_at_launch", true)
         )

  lifecycle {
    create_before_destroy = true
  }
}
