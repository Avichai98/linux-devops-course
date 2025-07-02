variable "subscription_id" {
  description = "The Azure subscription ID where resources will be created."
  type        = string
  default     = "63e736f9-c77b-48e5-aeaf-853e4c7cc4d1"
}

variable "tenant_id" {
  description = "The Azure tenant ID for authentication."
  type        = string
  default     = "79caa7d1-da42-47a2-b507-432ca23f0704"
}

variable "resource_group_name" {
  description = "The name of the resource group to create."
  type        = string
  default     = "rg-tfstate-week9"
}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "westeurope"
}

variable "storage_account_name" {
  description = "The name of the storage account for the Terraform backend."
  type        = string
  default     = "storageaccountweek9"
}

variable "container_name" {
  description = "The name of the container for the Terraform backend."
  type        = string
  default     = "terraform"
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {
    environment = "dev"
  }
}