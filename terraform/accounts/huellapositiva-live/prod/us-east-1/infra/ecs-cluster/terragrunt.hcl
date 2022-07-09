terraform {
  source = "../../../../../../components/ecs-cluster"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  ec2_instance_type = "t3a.small"
  ecs_min_instances = 1
  ecs_max_instances = 3
  ecs_desired_instances = 2
  scheduled_scaling = {
    enabled = 0
  }
  spot_instance_max_price = "0.0188"
  ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDE+aleuKgGFDa+DiOa9w27z63E0IKigO7XqGdX56pXiH/vU3sGxkWLU6O/X0rf9f3geAn6H5b8K0NJHrs9O0jpK6Q0eMOhFbV9ytWfk/ZE8toZQ/Czf4l8900irE9Z2fMnvW7p69fX3uxMNAS5F+jyI2hz7tnXW727sQwOpJjx4kTIhyrUksCG0T0JHcaDpnAMnRpc3gctIj5Q37lkVUHvoGXRgfVA1FEzfWNRlMRukD0AUYf02ndnm7n13gT2bTLM4BXzkb2RtiMmj9zsw7F3LWCP+tDiRbOB39smRv+oAZpfN5ollgSZNDsm6+rEMKGw/+JsFKsGUtkQIlUUL4sFgPogNv/u5WhseSHlsWGMjj7rK+1Zthkcf1p47/+Re/ZX7FKZtjngfo7thURfxbMcVPndC02f3mKTxYzoyrmbHSmHu5alJNc8hvxSrdEUZnRzPR9sUqf3C45rEm36wu4APytqVgUNQAnZOS8Jm3pHAlNe4jbxqPzWmRs0AMfZHZs="
}