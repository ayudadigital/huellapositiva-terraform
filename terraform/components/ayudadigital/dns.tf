

resource aws_route53_record a-root {
  zone_id = data.terraform_remote_state.domain.outputs.route53_zone_id
  name    = "ayudadigital.org"
  type    = "A"
  ttl     = "60"
  records = [ 54.37.163.90 ]
}

