resource aws_ecs_service ecs_service {
  name = "${var.project["name"]}-${var.service_name}-ecs-service"
  cluster = data.terraform_remote_state.ecs.outputs.ecs_cluster_id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count = var.ecs_task_initial_desired_count
  deployment_minimum_healthy_percent = "0"
  force_new_deployment = true

  ordered_placement_strategy {
    type = "spread"
    field = "attribute:ecs.availability-zone"
  }

  iam_role = data.terraform_remote_state.ecs.outputs.iam_service_role_arn
  health_check_grace_period_seconds = 180
  load_balancer {
    target_group_arn = aws_alb_target_group.alb_target_group.arn
    container_name = "${var.environment}-${var.service_name}-container"
    container_port = var.application_port
  }

  lifecycle {
    ignore_changes = [
      task_definition
    ]
  }
}