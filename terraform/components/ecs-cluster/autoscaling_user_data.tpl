#!/bin/bash
set -x
set -e

# Update instance
yum update -y

# Add all things that you want to do here (logging, monitoring, credential from S3, etc)

# Join ECS cluster
echo 'ECS_CLUSTER=${ECS_CLUSTER}' >> /etc/ecs/ecs.config
echo 'ECS_AVAILABLE_LOGGING_DRIVERS=["json-file","syslog","awslogs","journald","none"]' >> /etc/ecs/ecs.config
start ecs