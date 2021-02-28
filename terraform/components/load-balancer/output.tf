output loadbalancer {
  value = aws_alb.alb.arn_suffix
}

output loadbalancer_dns_name {
  value = aws_alb.alb.dns_name
}

output alb_listener_https_arn {
  value = aws_alb_listener.alb-https.arn
}
