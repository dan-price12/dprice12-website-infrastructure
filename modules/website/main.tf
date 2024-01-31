data "azurerm_client_config" "current" {}

data "azurerm_key_vault" "core_kv_data" {
  name                = var.core_kv_name
  resource_group_name = var.core_kv_rg_name
}

data "azurerm_key_vault_secret" "website_client_id" {
  name         = "WebsiteClientId"
  key_vault_id = data.azurerm_key_vault.core_kv_data.id
}

data "azurerm_key_vault_secret" "website_client_secret" {
  name         = "WebsiteClientSecret"
  key_vault_id = data.azurerm_key_vault.core_kv_data.id
}

data "azurerm_key_vault_secret" "website_source_email_id" {
  name         = "WebsiteSourceEmailId"
  key_vault_id = data.azurerm_key_vault.core_kv_data.id
}

data "azurerm_key_vault_secret" "website_destination_email" {
  name         = "WebsiteDestinationEmail"
  key_vault_id = data.azurerm_key_vault.core_kv_data.id
}

resource "azurerm_resource_group" "website_rg" {
  name     = var.website_rg_name
  location = var.location

  tags = {
    environment = var.environment
  }
}

resource "azurerm_static_site" "static_app" {
  name                = var.static_app_name
  resource_group_name = azurerm_resource_group.website_rg.name
  location            = azurerm_resource_group.website_rg.location

  app_settings = {
    "CLIENT_ID"         = data.azurerm_key_vault_secret.website_client_id.value
    "CLIENT_SECRET"     = data.azurerm_key_vault_secret.website_client_secret.value
    "DESTINATION_EMAIL" = data.azurerm_key_vault_secret.website_destination_email.value
    "SOURCE_EMAIL_ID"   = data.azurerm_key_vault_secret.website_source_email_id.value
    "TENANT_ID"         = data.azurerm_client_config.current.tenant_id
  }

  tags = {
    environment = var.environment
  }
}
