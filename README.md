# Setup 

### Steps:

1- Terraform user

    AWS console

2- Global users

    terraform/accounts/huellapositiva-live/global/us-east-1/infra/users

3- KMS (not free)

    terraform/accounts/huellapositiva-live/dev/global/infra/kms

4- VPC (free)

    terraform/accounts/huellapositiva-live/dev/us-east-1/infra/vpc

5- ECS cluster (free unless you set the desired instances of the auto scaling group)

    terraform/accounts/huellapositiva-live/dev/us-east-1/infra/ecs-cluster

6- Load Balancer (not free)

    terraform/accounts/huellapositiva-live/dev/us-east-1/infra/load-balancer

7- Backend (free)

    terraform/accounts/huellapositiva-live/dev/us-east-1/infra/backend
    
    validate no_reply email account manually

# Infrastructure

## VPC
### - Public Networks
### - ~~Private Networks - NAT~~
### - Internet Gateway
### - Security Group

## ECS
### - Autoscaling (group & schedule)
### - Services
### - Task definitions
### - Target Groups
### - Cloud Watch logs and metrics

## ECR
### Container registries

## Load Balancer
### ALB

## S3
### Terraform state
### Application data
### Application static content
### Management data

## IAM
### - ECR/S role
### - Jenkins user (deploy)
### - Read only roles (dev, mgmt)

## SSM
### Parameter store


## EC2 Instances
### Auto scaling groups (ECS pool and service level)
### Security Group (Apps)


## DB
### RDS instance


## MANUAL

### Initial Terraform user

### DNS conf?

## TODO

### Configure RDS

### Configure backups for S3 and RDS

### Configure Route 53
