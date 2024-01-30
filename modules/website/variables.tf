variable "environment" {
  type        = string
  description = "The name of the environment"
}

variable "website_rg_name" {
  type        = string
  description = "The name of the resource group for the website"
}

variable "location" {
  type        = string
  description = "The location for the resources"
}

variable "static_app_name" {
  type        = string
  description = "The name of the static web app"
}

variable "destination_email" {
  type        = string
  description = "The destination email address for the contact form"
}

variable "core_kv_name" {
  type        = string
  description = "The name of the Key Vault to use for the configuration settings"
}

variable "core_kv_rg_name" {
  type        = string
  description = "The name of the Key Vault's Resource Group"
}
