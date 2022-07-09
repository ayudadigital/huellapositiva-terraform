data aws_iam_policy_document ecs_agent {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource aws_iam_role ecs_agent {
  name               = "${var.project["name"]}-${var.environment}-ecs-instance"
  assume_role_policy = data.aws_iam_policy_document.ecs_agent.json
}


resource aws_iam_role_policy_attachment ecs_agent {
  role       = aws_iam_role.ecs_agent.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource aws_iam_instance_profile ecs_agent {
  name = "${aws_iam_role.ecs_agent.name}-profile"
  role = aws_iam_role.ecs_agent.name
}

data aws_iam_policy_document ecs_service {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource aws_iam_role ecs_service {
  name               = "${var.project["name"]}-${var.environment}-ecs-service"
  assume_role_policy = data.aws_iam_policy_document.ecs_service.json
}


resource aws_iam_role_policy_attachment ecs_service {
  role       = aws_iam_role.ecs_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}
