terraform {
  backend "s3" {}
}

provider aws {
  region = var.region
}

resource aws_iam_user jenkins {
  name = "${var.environment}-${var.project["name"]}-jenkins"
  path = "/system/"
}

resource aws_iam_access_key jenkins {
  user    = aws_iam_user.jenkins.name
  pgp_key = "keybase:huellapositiva"
}

resource aws_iam_user_policy_attachment ecs_deploy {
  user       = aws_iam_user.jenkins.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess" // TODO Limit
}

output jenkins_access_key_id {
  value = aws_iam_access_key.developer.id
}

output jenkins_access_key_secret {
  value = aws_iam_access_key.jenkins.encrypted_secret
}
