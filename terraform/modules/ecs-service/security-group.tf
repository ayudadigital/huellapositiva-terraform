resource aws_security_group_rule service_rule {
  type              = "ingress"
  from_port         = var.application_port
  to_port           = var.application_port
  protocol          = "tcp"
  cidr_blocks       = var.ingress_cidr != "" ? [var.ingress_cidr] : [data.terraform_remote_state.vpc.outputs.vpc_cidr_block]
  security_group_id = data.terraform_remote_state.ecs.outputs.ecs_security_group_id
}
