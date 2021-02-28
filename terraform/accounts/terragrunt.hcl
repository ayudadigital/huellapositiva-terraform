locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Automatically load resource-type-level variables
  resource_type_vars = read_terragrunt_config(find_in_parent_folders("resource-type.hcl"))

  # Extract the variables we need for easy access
  account_id   = local.account_vars.locals.aws_account_id
  region   = local.region_vars.locals.region
  env = local.environment_vars.locals.environment
  resource_type = local.resource_type_vars.locals.resource_type

  service_name = replace(path_relative_to_include(), "/.*\\//", "")

  project = {
    name = "huellapositiva"
  }

  state_bucket_name = "${local.project["name"]}-${local.env}-${local.account_vars.locals.state_bucket_name_suffix}"
}

remote_state {
  backend = "s3"
  config = {
    encrypt = true
    bucket = "${local.state_bucket_name}"
    key = "env-${local.env}/${local.resource_type}/${local.service_name}/${local.region}/terraform.tfstate"
    region = local.region
//    dynamodb_table = "huellapositiva-tf-lock-table"
    profile = "huellapositiva"
    skip_region_validation = true
  }
}

inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals,
  {service_name = local.service_name},
  {project = local.project},
  {state_bucket_name = local.state_bucket_name}
)