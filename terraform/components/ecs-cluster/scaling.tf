resource aws_autoscaling_schedule asg_scheduled_scale_down {
  count                  = var.scheduled_scaling["enabled"]

  scheduled_action_name  = "Scheduled Scale Down"
  min_size               = var.ecs_min_instances
  max_size               = var.ecs_max_instances
  desired_capacity       = 0
  recurrence             = var.scheduled_scaling["scale_down_cron_utc"]
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group.name
}

resource aws_autoscaling_schedule asg_scheduled_scale_up {
  count                  = var.scheduled_scaling["enabled"]

  scheduled_action_name  = "Scheduled Scale Up"
  min_size               = var.ecs_min_instances
  max_size               = var.ecs_max_instances
  desired_capacity       = var.ecs_desired_instances
  recurrence             = var.scheduled_scaling["scale_up_cron_utc"]
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group.name
}

resource aws_autoscaling_policy ecsClusterScaleInPolicy {
  name                   = "${var.environment}-ecs-cluster-scale-in-policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group.name
}

resource aws_autoscaling_policy ecsClusterScaleOutPolicy {
  name                   = "${var.environment}-ecs-cluster-scale-out-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group.name
}
