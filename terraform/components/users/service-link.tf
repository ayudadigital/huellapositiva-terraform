resource aws_iam_service_linked_role ecs {
  aws_service_name = "ecs.amazonaws.com"
  description = "Role to enable Amazon ECS to manage your cluster."
}

resource aws_iam_service_linked_role autoscaling {
  aws_service_name = "autoscaling.amazonaws.com"
  description = "Default Service-Linked Role enables access to AWS Services and Resources used or managed by Auto Scaling"
}

resource aws_iam_service_linked_role application_autoscaling {
  aws_service_name = "ecs.application-autoscaling.amazonaws.com"
}

resource aws_iam_service_linked_role load_balancer {
  aws_service_name = "elasticloadbalancing.amazonaws.com"
  description = "Allows ELB to call AWS services on your behalf."
}

resource aws_iam_service_linked_role rds {
  aws_service_name = "rds.amazonaws.com"
  description = "Allows Amazon RDS to manage AWS resources on your behalf"
}
