resource aws_security_group ecs_security_group {
  name = "${var.environment}-ecs-sg"
  description = "Security group ECS cluster"

  vpc_id = data.terraform_remote_state.vpc.outputs.id

  tags = {
    Name = "${var.environment}-ecs-sg"
    Environment = var.environment
    Project = var.project["name"]
  }
}

resource aws_security_group_rule ssh_rule {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_security_group.id
}

resource aws_security_group_rule http_rule {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_security_group.id
}

resource aws_security_group_rule https_rule {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_security_group.id
}

resource aws_security_group_rule outbound_rule {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_security_group.id
}
