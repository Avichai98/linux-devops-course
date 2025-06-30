
# Week 9 – Terraform Infrastructure on Azure

<details>
<summary><strong>Task 1 – Install and Configure Terraform ✅</strong></summary>

**Goal**: Install Terraform and configure Azure CLI for Terraform usage.

---

### 🧰 Installation Instructions:

```bash

# Install Terraform
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null
sudo apt-get update && sudo apt-get install terraform -y
terraform -version
```

---

### 🌐 Configure Azure CLI:

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

### ✅ Verify Subscription

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

### ✏️ Steps:

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
#### 📌 Explanation:
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
#### 📌 Explanation:
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
#### 📌 Explanation:
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

### 🚀 Terraform Commands:

2. Initialize Terraform:

```bash
terraform init
```
#### 📌 Explanation:
- Initializes the current working directory as a Terraform project.
- Downloads the required provider plugins (in this case, AzureRM).
- Creates the `.terraform` directory which stores configuration files for the project.

You must run this command **before** using `plan` or `apply`.

---

3. Plan the execution:

```bash
terraform plan
```
#### 📌 Explanation:
- Displays the execution plan: what Terraform will create, update, or destroy.
- It’s a **safe preview** that shows changes without applying them.
- Recommended to run before every `apply` to verify the desired outcome.

The plan shows the current status vs. the desired configuration.

---

4. Apply the configuration:

```bash
terraform apply
```
#### 📌 Explanation:
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

✅ **Goal**: Extend Terraform configuration to deploy a virtual network.

---

### ✏️ Example Virtual Network Configuration:

```hcl
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-week9"
  address_space       = ["10.0.0.0/24"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
```

1. Run:

```bash
terraform plan
terraform apply
```

✅ Verify that the virtual network is created successfully.

</details>

---

<details>
<summary><strong>Task 4 – Organize Terraform Code with Modules</strong></summary>

✅ **Goal**: Refactor the project using modules for better structure.

---

### 📂 Suggested Folder Structure:

```text
.
├── main.tf
├── modules/
│   ├── resource_group/
│   │   └── main.tf
│   ├── virtual_network/
│   │   └── main.tf
│   └── virtual_machine/
│       └── main.tf
├── variables.tf
└── outputs.tf
```

---

✅ Use `terraform plan` and `terraform apply` to verify the modular deployment.

</details>

---

<details>
<summary><strong>Task 5 – Remote State with Azure Storage</strong></summary>

✅ **Goal**: Configure remote state storage and enable logging.

---

### 📦 Backend Configuration Example:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "myResourceGroup"
    storage_account_name = "mystorageaccount"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
```

---

### 🔍 Logging and Debugging:

Enable debug logs:

```bash
TF_LOG=DEBUG terraform apply 2>&1 | tee tf_debug.log
```

✅ Verify that the remote state is correctly stored in the Azure Storage Account.

</details>

---

<details>
<summary><strong>Task 6 – Advanced Practice: Import and Cleanup</strong></summary>

✅ **Goal**: Practice resource import and cleanup.

---

### ✏️ Import Resource Example:

```bash
terraform import azurerm_virtual_machine.example /subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.Compute/virtualMachines/xxx
```

✅ Confirm that the resource is now managed by Terraform.

---

### 🧹 Destroy All Resources:

```bash
terraform destroy
```

✅ Verify resource deletion in Azure Portal.

</details>
