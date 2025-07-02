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

  subscription_id = "63e736f9-c77b-48e5-aeaf-853e4c7cc4d1"
  tenant_id       = "79caa7d1-da42-47a2-b507-432ca23f0704"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-import-week9"
  location = "westeurope"
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "vm-import-week9"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = "Standard_B1s"
  admin_username        = "avichai"
  network_interface_ids = ["/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/rg-import-week9/providers/Microsoft.Network/networkInterfaces/nic-vm-import-week9"]

  admin_ssh_key {
    username   = "avichai"
    public_key = file("~/.ssh/terraform.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  secure_boot_enabled = true
  vtpm_enabled        = true
}
