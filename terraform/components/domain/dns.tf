resource aws_route53_record ns {
  allow_overwrite = true
  name            = var.domain
  ttl             = 60 // Default: 172800
  type            = "NS"
  zone_id         = aws_route53_zone.domain.zone_id

  records = [
    aws_route53_zone.domain.name_servers[0],
    aws_route53_zone.domain.name_servers[1],
    aws_route53_zone.domain.name_servers[2],
    aws_route53_zone.domain.name_servers[3],
  ]
}

resource aws_route53_record soa {
  allow_overwrite = true
  name            = var.domain
  ttl             = 30 // 900
  type            = "SOA"
  zone_id         = aws_route53_zone.domain.zone_id

  records = [
    format("%s. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400", aws_route53_zone.domain.name_servers[0])
  ]
}

//resource aws_route53_record mx1 {
//  zone_id = aws_route53_zone.domain.zone_id
//  name    = ""
//  type    = "MX"
//  ttl     = "30"
//  records = aws_route53_zone.dev.name_servers
//}