resource aws_launch_configuration launch_configuration {
  name = "${var.project["name"]}-${var.environment}-ecs-cluster-lc"
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
  key_name   = "huellapositiva_${var.environment}"
  public_key = var.ssh_key
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
    ignore_changes = [ desired_capacity ]
  }
}
