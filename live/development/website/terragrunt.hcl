include {
  path = find_in_parent_folders()
}

dependency "core-services" {
  config_path = "../core-services"
}

terraform {
  source = "${get_parent_terragrunt_dir()}/modules/website"
}

inputs = {
  static_app_name   = "stapp-website-dev-useast2-001"
  destination_email = "info@salienttechconsulting.com"
  website_rg_name   = "rg-website-dev-001"
  core_kv_name      = dependency.core-services.outputs.core_kv.name
  core_kv_rg_name   = dependency.core-services.outputs.core_rg.name
}
