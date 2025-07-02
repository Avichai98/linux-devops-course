
# Week 9 – Terraform Infrastructure on Azure

<details>
<summary><strong>Task 1 – Install and Configure Terraform ✅</strong></summary>

**Goal**: Install Terraform and configure Azure CLI for Terraform usage.

---

### Installation Instructions:

```bash

# Install Terraform
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null
sudo apt-get update && sudo apt-get install terraform -y
terraform -version
```

---

### Configure Azure CLI:

```bash
# Install Azure CLI
curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=$(dpkg --print-architecture)] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-get update
sudo apt-get install azure-cli -y
az version
az login
```

### Verify Subscription

After login, verify that you are connected to the correct Azure subscription:

```bash
az account show
```

If you need to switch to a different subscription:

```bash
az account set --subscription "<Your Subscription ID>"
```

You can list all available subscriptions with:

```bash
az account list --output table
```

Make sure the active subscription is the one you intend to work with for this project.

</details>

---

<details>
<summary><strong>Task 2 – Write Basic Terraform Configuration ✅</strong></summary>

**Goal**: Create a basic Terraform configuration to provision a Resource Group in Azure.

---

### Steps:

1. Create a `main.tf` file:

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}
```
#### Explanation:
This block defines the required Terraform provider.  
- `required_providers`: Specifies the provider needed to interact with Azure.
- `source = "hashicorp/azurerm"`: Uses the official Azure provider from HashiCorp.
- `version = "~> 3.0"`: Ensures that Terraform uses provider version 3.x for stability and compatibility.

---

```hcl
provider "azurerm" {
  features {}
}
```
#### Explanation:
This block configures the Azure provider.
- `features {}`: Required syntax, can remain empty unless specific features are used.
- This configuration uses **dynamic subscription selection**, meaning Terraform will automatically use the subscription from your Azure CLI login.

To check your current Azure subscription:
```bash
az account show
```
To switch to another subscription:
```bash
az account list --output table
az account set --subscription "Your Subscription Name or ID"
```

❗ If you want to lock the provider to a specific subscription, you can write:
```hcl
provider "azurerm" {
  features {}
  subscription_id = "your-subscription-id"
  tenant_id       = "your-tenant-id"
}
```
But this is usually recommended for production environments.

---

```hcl
resource azurerm_resource_group "rg" {
    name     = "rg-week9"
    location = "westeurope"
}
```
#### Explanation:
This block creates a Resource Group in Azure.
- `azurerm_resource_group`: Specifies the type of resource to create.
- `"rg"`: Logical Terraform name (used for referencing the resource later).
- `name = "rg-week9"`: The name of the resource group that will appear in the Azure Portal.
- `location = "westeurope"`: The Azure region where the resource group will be deployed.

**Note:** Make sure the location name is correct. Use:
```bash
az account list-locations --output table
```
Example of valid region: `westeurope`  
**Incorrect example:** `wwesteurope`

---

### Terraform Commands:

2. Initialize Terraform:

```bash
terraform init
```
#### Explanation:
- Initializes the current working directory as a Terraform project.
- Downloads the required provider plugins (in this case, AzureRM).
- Creates the `.terraform` directory which stores configuration files for the project.

You must run this command **before** using `plan` or `apply`.

---

3. Plan the execution:

```bash
terraform plan
```
#### Explanation:
- Displays the execution plan: what Terraform will create, update, or destroy.
- It’s a **safe preview** that shows changes without applying them.
- Recommended to run before every `apply` to verify the desired outcome.

The plan shows the current status vs. the desired configuration.

---

4. Apply the configuration:

```bash
terraform apply
```
#### Explanation:
- Applies the changes required to reach the desired state of the configuration.
- Executes the creation, modification, or deletion of resources.
- Requires manual confirmation by typing `yes`.

After this step, the resources are created and visible in the Azure Portal.

---

Confirm the creation of the resource group in the Azure Portal.

</details>

---

<details>
<summary><strong>Task 3 – Define and Deploy a Virtual Network ✅</strong></summary>

## Goal
Extend the Terraform configuration to provision a complete Azure Virtual Machine (VM) infrastructure. This includes:
- Virtual Network (VNet)
- Subnet
- Network Security Group (NSG) and Security Rules
- Public IP
- Network Interface (NIC)
- Linux Virtual Machine (VM)
- Use of `variables.tf` and `outputs.tf` for flexibility and visibility

---

## Steps

### 1. Define the Virtual Network

```hcl
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-week9"
  address_space       = var.address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags = {
    environment = var.tags["environment"]
  }
}
```
#### Explanation:
- Creates a virtual network (VNet) for the VM.
- `address_space` defines the range of IP addresses for the network.
- Tags are used for environment identification.

---

### 2. Define the Subnet

```hcl
resource "azurerm_subnet" "subnet" {
  name                 = "subnet-week9"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefix
}
```
#### Explanation:
- Subnet splits the virtual network into smaller address spaces.
- The subnet is linked to the virtual network.

---

### 3. Define the Network Security Group (NSG)

```hcl
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-week9"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags = {
    environment = var.tags["environment"]
  }
}
```
#### Explanation:
- Creates a security layer that controls inbound and outbound traffic.

---

### 4. Define Security Rules

#### Allow SSH:
```hcl
resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = "allow-ssh"
  description                 = "Allow SSH traffic"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.nsg.name
  resource_group_name         = azurerm_resource_group.rg.name
}
```

#### Allow Application Ports:
```hcl
resource "azurerm_network_security_rule" "allow_app_ports" {
  name                        = "allow-app-ports"
  description                 = "Allow application ports"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = var.app_ports
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.nsg.name
  resource_group_name         = azurerm_resource_group.rg.name
}
```
#### Explanation:
- Allows SSH access on port 22.
- Opens additional application ports (3000, 8000) using a variable.

---

### 5. Associate NSG with Subnet

```hcl
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
```
#### Explanation:
- Links the security group to the subnet to enforce the rules.

---

### 6. Create a Public IP Address

```hcl
resource "azurerm_public_ip" "public_ip" {
  name                = "public-ip-week9"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    environment = var.tags["environment"]
  }
}
```
#### Explanation:
- Allocates a static public IP for external VM access.

---

### 7. Create a Network Interface

```hcl
resource "azurerm_network_interface" "nic" {
  name                = "nic-week9"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig-week9"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}
```
#### Explanation:
- Connects the VM to the network using the subnet and public IP.

---

### 8. Create a Linux Virtual Machine

```hcl
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-week9"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_size
  admin_username      = var.adminuser
  network_interface_ids = [azurerm_network_interface.nic.id]

  admin_ssh_key {
    username   = var.adminuser
    public_key = file(var.admin_ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = {
    environment = var.tags["environment"]
  }
}
```
#### Explanation:
- Creates the virtual machine using Ubuntu Server.
- Configures SSH access via public key authentication.
- Uses the **OS Disk** block to define:
  - `caching = "ReadWrite"`: Improves performance by caching both read and write operations.
  - `storage_account_type = "Standard_LRS"`: Uses a locally redundant standard storage account for the VM's OS disk.

---

## 📂 Additional Files

### 1. `variables.tf`

```hcl
variable "subscription_id" { ... }
variable "tenant_id" { ... }
variable "resource_group_name" { ... }
variable "adminuser" { ... }
variable "admin_ssh_public_key_path" { ... }
variable "admin_ssh_private_key_path" { ... }
variable "location" { ... }
variable "vm_size" { ... }
variable "vm_name" { ... }
variable "subnet_address_prefix" { ... }
variable "address_space" { ... }
variable "app_ports" { ... }
variable "tags" { ... }
```

#### Explanation:
- Defines all the parameters that allow **dynamic configuration**.
- Includes SSH key paths, resource names, and allowed ports.

---

### 2. `outputs.tf`

```hcl
output "public_ip_address" { ... }
output "virtual_machine_id" { ... }
output "admin_username" { ... }
output "ssh_connection_string" { ... }
output "resource_group_name" { ... }
output "source_image_reference" { ... }
output "address_space" { ... }
output "subnet_address_prefix" { ... }
output "app_ports" { ... }
```

#### Explanation:
- Displays the outputs **after deployment**.
- Provides easy access to the public IP, SSH connection string, VM ID, and other important info.

---

## Terraform Commands

```bash
terraform init
terraform plan
terraform apply
terraform output
```

---

### Verify the Deployment and SSH Connection

After successfully applying the configuration and seeing the outputs, especially the `ssh_connection_string`, verify that you can connect to the VM.

Run the following command in your terminal:

```bash
ssh -i ~/.ssh/terraform adminuser@<Public-IP>
```

Or directly use the connection string provided in the output:

```bash
ssh -i ~/.ssh/terraform adminuser@<Public-IP>
```

> **Note:**  
> Replace `~/.ssh/terraform` with the actual path to your **private SSH key** if you used a different one.

This confirms that:
- The VM was created successfully.
- The network configuration is correct.
- The SSH key was set correctly.
- You have remote access to the VM.

---

## Summary
You now have a full Azure VM infrastructure deployed via Terraform, using a well-structured and flexible setup with variables and outputs.


</details>

---

<details>
<summary><strong>Task 4 – Organize Terraform Code with Modules ✅</strong></summary>

## Goal
Refactor the Terraform project to use **modular structure**: separate the **Resource Group**, **Networking**, and **Virtual Machine** into independent modules.

---

## 📂 Folder Structure

```
project-root/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfstate
├── modules/
│   ├── resource_group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── virtual_machine/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
```

---

## Explanation

### Root Files
- **main.tf**: Calls each module and passes the required variables.
- **variables.tf**: Defines global variables.
- **outputs.tf**: Collects outputs from modules (such as public IP address, VM ID, etc.).

### Modules
Each module is an isolated component that can be reused.

#### 📂 modules/resource_group/
- Creates the Azure Resource Group.
- Receives `resource_group_name`, `location`, and `tags` as input variables.
- Outputs the resource group name and location for other modules to consume.

#### 📂 modules/network/
- Creates the Virtual Network, Subnet, NSG, Security Rules, Public IP, and Network Interface.
- Depends on the Resource Group module.
- Outputs the Public IP address and the NIC ID for the VM.

#### 📂 modules/virtual_machine/
- Creates the Virtual Machine using Ubuntu Server.
- Configures SSH access via public key authentication.
- Depends on the Network module to receive the NIC ID.
- Outputs the VM ID and SSH connection string.

---

## Check the plan:
```bash
terraform plan
```

## Apply the configuration:
```bash
terraform apply
```

</details>

---

<details>
<summary><strong>Task 5 – Remote State with Azure Storage ✅</strong></summary>

## Goal
Set up remote state management using Azure Storage, migrate Terraform state to remote backend, and enable logging and debugging.

---

## 📂 Folder Structure

```
project-root/
├── bootstrap/              # Folder for creating remote backend resources
│   ├── main.tf             # Storage Account, Container, and Resource Group creation
│   ├── variables.tf        # Variables specific to remote state resources
│   ├── outputs.tf          # Outputs for storage account and container names
│   └── terraform.tfstate   # Temporary local state before backend migration
├── main.tf                 # Root configuration with backend and module calls
├── variables.tf            # Project-level variables
├── outputs.tf              # Project-level outputs
├── terraform.tfstate       # Managed by Terraform, do not edit
├── terraform.tfstate.backup
├── .terraform.lock.hcl
├── modules/
│   ├── resource_group/
│   ├── network/
│   └── virtual_machine/

```

---

## Steps

### Step 1: Create Remote State Infrastructure

In `bootstrap/main.tf`:
```hcl
resource "azurerm_resource_group" "rg" {
  name     = "rg-tfstate-week9"
  location = var.location
  tags     = var.tags
}

resource "azurerm_storage_account" "sa_week9" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

resource "azurerm_storage_container" "terraform" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.sa_week9.id
  container_access_type = "private"
}
```

Deploy using:
```bash
terraform init
terraform apply
```

---

### Step 2: Configure Remote Backend

In the **main project’s main.tf**:
```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-week9"
    storage_account_name = "your_storage_account_name"
    container_name       = "your_container_name"
    key                  = "terraform.tfstate"
  }
}
```

Run:
```bash
terraform init
```

Confirm migration by typing:
```bash
yes
```

---

### Step 3: Test Remote State

Make a small change (like a tag) and run:
```bash
terraform plan
terraform apply
```

Ensure the state is now saved remotely.

---

### Step 4: Enable Debug Logging

Run with debugging:
```bash
TF_LOG=DEBUG terraform apply
```

Save the logs to a file:
```bash
TF_LOG=DEBUG terraform apply 2>&1 | tee tf_debug.log
```

Review the log file for backend interactions.

---

## Summary
- Created Azure Storage for remote backend.
- Migrated Terraform state to remote backend.
- Verified functionality.
- Enabled and saved debug logs.

</details>

---

<details>
<summary><strong>Task 6 – Advanced Practice: Import and Cleanup ✅</strong></summary>

## Goal:
Import an existing Azure VM into Terraform state and manage it with Terraform.

---

## 📁 Folder Structure:
```text
project-root/
└── import_vm/
    ├── main.tf         # Terraform configuration file for imported VM
    └── terraform.tfstate # Terraform state file after import
```

---

## Steps:

### 1. Create a Virtual Machine using Azure CLI
Run the following command to create a VM manually in Azure:

```bash
az vm create \
  --resource-group rg-import-week9 \
  --name vm-import-week9 \
  --image Ubuntu2404 \
  --admin-username avichai \
  --ssh-key-values ~/.ssh/terraform.pub \
  --size Standard_B1s
```

### 2. Prepare Terraform Configuration
Write the following in `import_vm/main.tf`:

```hcl
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

  subscription_id = {subscription_id}
  tenant_id       = {tenant_id}
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "vm-import-week9"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = "Standard_B1s"
  admin_username        = "avichai"
  network_interface_ids = [{nic_id}]

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
```

*(Ensure the VM configuration matches the existing VM or update it after import.)*

---

### 3. Initialize Terraform
Run:
```bash
terraform init
```

---

### 4. Import the VM
Run:
```bash
terraform import azurerm_linux_virtual_machine.vm /subscriptions/{subscription_id}/resourceGroups/rg-import-week9/providers/Microsoft.Compute/virtualMachines/vm-import-week9
```

You should see `Import successful!`

---

### 5. Validate with `terraform plan`
Run:
```bash
terraform plan
```

If there are no changes – the import was correct.  
If there are differences – update `main.tf` to match the current VM.

---

### 6. Destroy the VM
Run:
```bash
terraform destroy
```

Make sure the VM and resource group are deleted from the Azure Portal.

---

</details>
