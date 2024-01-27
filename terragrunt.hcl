locals {
  # Automatically load environment-level variables
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract the variables we need for easy access
  subscription_id = get_env("ARM_SUBSCRIPTION_ID")
  client_id       = get_env("ARM_CLIENT_ID")
  tenant_id       = get_env("ARM_TENANT_ID")
  core_rg_name    = local.env_vars.locals.core_rg_name
  sa_name         = local.env_vars.locals.sa_name
  container_name  = local.env_vars.locals.container_name
}

# Generate an Azure provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}
EOF
}

# Configure Azure as a backend
remote_state {
  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    subscription_id      = local.subscription_id
    resource_group_name  = local.core_rg_name
    storage_account_name = local.sa_name
    container_name       = local.container_name
    key                  = "${path_relative_to_include("site")}/terraform.tfstate"
  }
}

terraform {
  # Force Terraform to keep trying to acquire a lock for
  # up to 20 minutes if someone else already has the lock
  extra_arguments "retry_lock" {
    commands = get_terraform_commands_that_need_locking()

    arguments = [
      "-lock-timeout=20m"
    ]
  }
}

inputs = merge(
  local.env_vars.locals
)
