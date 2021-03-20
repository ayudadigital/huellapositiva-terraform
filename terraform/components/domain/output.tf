output route53_zone_id {
  value = aws_route53_zone.domain.zone_id
}

output root_domain_name {
  value = aws_route53_zone.domain.name
}
