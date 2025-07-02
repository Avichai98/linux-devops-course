terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.34"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}


resource "azurerm_resource_group" "rg" {
  name     = "rg-tfstate-week9"
  location = var.location

  tags = var.tags
}

resource "azurerm_storage_account" "sa_week9" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

resource "azurerm_storage_container" "terraform" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.sa_week9.id
  container_access_type = "private"
}


