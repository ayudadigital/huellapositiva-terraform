data aws_iam_policy_document ecs_service_role {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource aws_iam_role ecs_service_role {
  name               = "ecsServiceRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_service_role.json
}

resource aws_iam_role_policy_attachment ecs_service_role {
  role       = aws_iam_role.ecs_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

data aws_iam_policy_document ecs_autoscale_role {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["application-autoscaling.amazonaws.com"]
    }
  }
}

resource aws_iam_role ecs_autoscale_role {
  name               = "ecsAutoscaleRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_autoscale_role.json
}

resource aws_iam_role_policy_attachment ecs_autoscale_role {
  role       = aws_iam_role.ecs_autoscale_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}