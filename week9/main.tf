terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-week9"
    storage_account_name = "storageaccountweek9"
    container_name       = "terraform"
    key                  = "terraform.tfstate"
  }

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



module "resource_group" {
  source = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  tags   = var.tags
}

module "network" {
  source              = "./modules/network"
  resource_group_name = var.resource_group_name
  location            = module.resource_group.location
  tags                = var.tags
}

module "virtual_machine" {
  source              = "./modules/virtual_machine"
  location            = module.resource_group.location
  resource_group_name = var.resource_group_name
  nic_id              = module.network.nic_id
  tags                = var.tags
}
