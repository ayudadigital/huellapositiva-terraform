resource aws_route53_record alb {
  zone_id = data.terraform_remote_state.domain.outputs.route53_zone_id
  name    = var.hostname
  type    = "A"
  ttl     = "300"
  records = aws_alb.alb.dns_name
}