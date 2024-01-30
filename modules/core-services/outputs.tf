output "core_rg" {
  description = "The Core Resource Group"
  value = azurerm_resource_group.core_rg
}

output "core_kv" {
  description = "The Core Key Vault"
  value = azurerm_key_vault.core_kv
}
