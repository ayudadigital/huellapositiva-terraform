[
  {
    "name": "${name}",
    "image": "${docker_image}",
    "essential": true,
    "cpu": ${cpu},
    "memory": ${memory},

    "portMappings": [
      {
        "containerPort": ${application_port},
        "hostPort": ${application_port}
      }
    ],
    "environment":[
      {
        "name" : "HOST_IP_COMMAND",
        "value" : "curl http://169.254.169.254/latest/meta-data/local-ipv4"
      },
      {
        "name" : "PROFILE",
        "value" : "${environment}"
      },
      {
        "name" : "AWS_REGION",
        "value" : "${aws_region}"
      },
      {
        "name" : "SERVICE_NAME",
        "value" : "${service_name}"
      },
      {
        "name" : "BASE_URI",
        "value" : "${base_url}"
      }
      ${service_env_variables}
    ]
  }
]