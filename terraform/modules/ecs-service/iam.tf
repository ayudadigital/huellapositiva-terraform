data aws_iam_policy_document ecs_service_task {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com", "ecs-tasks.amazonaws.com"]
    }
  }
}

resource aws_iam_role ecs_service_task {
  name               = "${var.project["name"]}-${var.environment}-ecs-service-${var.service_name}"
  assume_role_policy = data.aws_iam_policy_document.ecs_service_task.json
}

resource aws_iam_role_policy_attachment ecs_service_task {
  role       = aws_iam_role.ecs_service_task.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource aws_iam_role_policy_attachment ecs_service_task_other {
  count = length(var.service_policies)
  role       = aws_iam_role.ecs_service_task.name
  policy_arn = element(var.service_policies, count.index)
}

resource aws_iam_role ecs_service_task_execution {
  name               = "${var.project["name"]}-${var.environment}-ecs-service-${var.service_name}-execution"
  assume_role_policy = data.aws_iam_policy_document.ecs_service_task.json
}

resource aws_iam_role_policy_attachment ecs_service_task_execution {
  role       = aws_iam_role.ecs_service_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
