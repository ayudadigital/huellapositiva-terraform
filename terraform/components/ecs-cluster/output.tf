output ecs_cluster_id {
  value = aws_ecs_cluster.ecs_cluster.id
}

output ecs_cluster_arn {
  value = aws_ecs_cluster.ecs_cluster.arn
}

output ecs_cluster_name {
  value = aws_ecs_cluster.ecs_cluster.name
}

output ecs_security_group_id {
  value = aws_security_group.ecs_security_group.id
}

output iam_service_role_arn {
  value = aws_iam_role.ecs_service.arn
}
