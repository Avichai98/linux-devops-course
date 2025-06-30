
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource azurerm_resource_group "rg" {
    name     = "rg-week9"
    location = "westeurope"
}

resource azurerm_virtual_network "vnet" {
    name                = "vnet-week9"
    address_space       = ["10.0.0.0/24"]
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
    name                 = "subnet-week9"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = [
        cidrsubnet(azurerm_virtual_network.vnet.address_space[0], 2, 1)
    ]
}
