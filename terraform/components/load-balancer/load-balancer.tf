terraform {
  backend "s3" {}
}

provider aws {
  region = var.region
}

locals {
  public_subnet_ids = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  public_subnet_id = local.public_subnet_ids[0]
  deregistration_delay = 30
}

resource aws_security_group elb_security_group {
  name = "${var.environment}-alb-sg"
  description = "Security group for load-balancer"

  vpc_id = data.terraform_remote_state.vpc.outputs.id

  tags = {
    Name = "${var.environment}-alb-sg"
    Environment = var.environment
    Project = var.project["name"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource aws_alb alb {
  name = "${var.environment}-ecs-cluster-alb"
  subnets = local.public_subnet_ids
  security_groups = [
    aws_security_group.elb_security_group.id
  ]

  enable_cross_zone_load_balancing = true
  idle_timeout = 400
}

resource aws_alb_listener alb-http {
  load_balancer_arn = aws_alb.alb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource aws_alb_listener alb-https {
  load_balancer_arn = aws_alb.alb.arn
  port = "443"
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn = "arn:aws:acm:us-east-1:258586964218:certificate/3944cc61-8e12-45c5-9267-5110364f0641"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Content Not Found"
      status_code  = "404"
    }
  }
}
