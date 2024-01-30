variable "environment" {
  type        = string
  description = "The name of the environment"
}

variable "core_rg_name" {
  type        = string
  description = "The name of the resource group for the storage account"
}

variable "location" {
  type        = string
  description = "The location for the resources"
}

variable "sa_name" {
  type        = string
  description = "The name of the storage account"
}

variable "container_name" {
  type        = string
  description = "The name of the container"
}
