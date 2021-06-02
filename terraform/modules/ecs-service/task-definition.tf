data template_file task_definition {
  template = file("${path.module}/task_definition.tpl")

  vars = {
    application_port = var.application_port
    service_name = var.service_name
    environment = var.environment
    cpu = var.cpu
    memory = var.memory
    docker_image = var.docker_image
    aws_region = var.region
    name = "${var.environment}-${var.service_name}-container"
    base_url = "https://${var.hostname}"
    aws_log_driver = var.cloudwatch_logs_enabled ? "awslogs" : "journald"
    aws_log_options = var.cloudwatch_logs_enabled ? local.aws_log_options_cloudwatch : local.aws_log_options_journald
    service_env_variables = var.service_env_variables
  }
}

locals {
  aws_log_options_journald = jsonencode({})
  aws_log_options_cloudwatch = jsonencode({
    "awslogs-group": var.cloudwatch_logs_enabled ? aws_cloudwatch_log_group.task_log_group[0].name : null,
    "awslogs-region": var.region,
    "awslogs-stream-prefix": "awslogs-${var.environment}-${var.project["name"]}-${var.service_name}"
  })
}

resource aws_ecs_task_definition ecs_task_definition {
  family = "${var.environment}-${var.project["name"]}-${var.service_name}-td"
  container_definitions = data.template_file.task_definition.rendered
  cpu = var.cpu
  memory = var.memory
  task_role_arn = aws_iam_role.ecs_service_task.arn
  execution_role_arn = aws_iam_role.ecs_service_task_execution.arn
  requires_compatibilities = [ "EC2" ]

  lifecycle {
    create_before_destroy = true
  }
}

resource aws_cloudwatch_log_group task_log_group {
  count = var.cloudwatch_logs_enabled ? 1 : 0
  name = "${var.environment}-${var.project["name"]}-${var.service_name}-lg"

  tags = {
    Name = "${var.environment}-${var.project["name"]}-${var.service_name}-lg"
    Environment = var.environment
    Application = "${var.environment}-${var.project["name"]}-${var.service_name}"
    Project = var.project["name"]
  }
}
