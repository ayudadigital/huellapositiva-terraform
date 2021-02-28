resource aws_alb_target_group alb_target_group {
  name = "${var.environment}-${var.service_name}-alb-tg"
  port = var.application_port
  protocol = "HTTP"
  deregistration_delay = 30
  vpc_id = data.terraform_remote_state.vpc.outputs.id
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    path = var.alb_health_check_path
    interval = 30
  }
}

resource aws_alb_listener_rule alb_listener_rule {
  listener_arn = data.terraform_remote_state.load-balancer.outputs.alb_listener_https_arn
  priority = var.alb_listener_rule_priority
  action {
    type = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group.arn
  }
  condition {
    path_pattern {
      values = var.alb_path_patterns
    }
  }
  condition {
    host_header {
      values = var.host_headers
    }
  }
}