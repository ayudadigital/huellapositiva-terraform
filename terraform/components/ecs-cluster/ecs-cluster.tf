terraform {
  backend "s3" {}
}

provider aws {
  region = var.region
}

resource aws_ecs_cluster ecs_cluster {
  name = "${var.environment}-ecs-cluster"

  setting {
    name = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "${var.environment}-ecs-cluster"
    Environment = var.environment
    Project = var.project["name"]
  }
}
