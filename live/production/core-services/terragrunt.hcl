include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/modules/core-services"
}

inputs = {
  kv_name = "kv-prod-useast2-001"
}
