data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "core_rg" {
  name     = var.core_rg_name
  location = var.location

  tags = {
    environment = var.environment
  }
}

resource "azurerm_key_vault" "core_kv" {
  name                        = var.kv_name
  location                    = azurerm_resource_group.core_rg.location
  resource_group_name         = azurerm_resource_group.core_rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
    ]
  }

  tags = {
    environment = var.environment
  }

  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
  }
}

module "storage" {
  source         = "./storage"
  environment    = var.environment
  core_rg_name   = var.core_rg_name
  location       = var.location
  sa_name        = var.sa_name
  container_name = var.container_name
}
