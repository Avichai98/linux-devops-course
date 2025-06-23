# Week 8 – Azure Infrastructure Practice Tasks

<details>
<summary><strong>Task 1 – Setup Azure CLI Environment ✅</strong></summary>

✅ **Goal**: Install and configure the Azure CLI on your machine.

---

### 🧰 Installation Instructions:

#### On Ubuntu:

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

#### On macOS:

```bash
brew update && brew install azure-cli
```

#### On Windows:

Download from: [https://aka.ms/installazurecli](https://aka.ms/installazurecli)

---

### 🧪 Verify:

```bash
az login
az account show
```

These commands let you log into your Azure account and confirm that you're authenticated and connected to the correct subscription.

</details>

---

<details>
<summary><strong>Task 2 – Create a Resource Group and VM via CLI ✅</strong></summary>

✅ **Goal**: Use Azure CLI to create a resource group and a virtual machine.

---

## 1. Create a Resource Group

A resource group is a logical container for Azure resources. All resources for a solution are typically deployed into a single resource group.

```bash
az group create --name myResourceGroup --location eastus
```

**Explanation for `az group create`:**
* `--name myResourceGroup`: Specifies the name of the resource group. Choose a descriptive name that helps you organize your resources.
* `--location eastus`: Specifies the Azure region where the resource group will be created. This location is for the metadata of the resource group itself and does not necessarily dictate the location of the resources within it (though it's common practice to keep them in the same region).

---

## 2. Create an Azure Virtual Machine (VM)

This command creates a new Ubuntu Linux VM with configurations aimed at minimizing cost.

```bash
az vm create \
  --resource-group MyResourceGroup \
  --name MyVM \
  --image UbuntuLTS \
  --admin-username azureuser \
  --generate-ssh-keys \
  --location westeurope \
  --size Standard_B1ls \
  --os-disk-size-gb 30 \
  --os-disk-type Standard_SSD_LRS \
  --public-ip-address-sku Basic \
  --no-wait
```

**Explanation for `az vm create`:**
* `--resource-group MyResourceGroup`: Specifies the name of the resource group where the VM will be created. This must be an existing resource group that you created previously.
* `--name MyVM`: Specifies the name of the new Virtual Machine. Choose a unique and descriptive name. This will be part of the VM's DNS name if you assign a public IP.
* `--image UbuntuLTS`: Specifies the operating system image to use for the VM. 'UbuntuLTS' refers to the latest Long Term Support version of Ubuntu, which is good for stability.
* `--admin-username azureuser`: Sets the administrator username for the VM. This user will have `sudo` (superuser do) privileges on the Linux VM.
* `--generate-ssh-keys`: Automatically generates a new SSH key pair (if one doesn't already exist in your `~/.ssh/` directory) and securely stores the private key on your local machine. The public key is then deployed to the VM, enabling secure passwordless SSH access.
* `--location westeurope`: Specifies the Azure region where the VM will be deployed. This is a critical parameter for pricing and latency. Different regions have varying costs, so choosing an optimal region like `westeurope` or `eastus` can significantly impact your bill.
* `--size Standard_B1ls`: Defines the VM size, which determines its computational resources (vCPUs, RAM) and is the most significant factor affecting cost. 'Standard_B1ls' is typically the smallest and most cost-effective burstable VM size, ideal for light workloads, development, or testing environments.
* `--os-disk-size-gb 30`: Sets the size of the operating system disk in Gigabytes (GB). A smaller disk generally results in lower storage costs. 30GB is a common and usually sufficient minimum for a Linux OS.
* `--os-disk-type Standard_SSD_LRS`: Specifies the storage type for the OS disk. 'Standard_SSD_LRS' (Locally Redundant Storage) provides a good balance of performance and cost, offering better performance than HDDs at a reasonable price, and is generally resilient.
* `--public-ip-address-sku Basic`: (Optional, but recommended for cost) Specifies the SKU for the public IP address. 'Basic' is typically cheaper than 'Standard' and is sufficient for most basic connectivity needs (e.g., SSH, web access).
* `--no-wait`: (Optional) This flag allows the command to return control to your command line immediately, letting you continue with other tasks while the VM creation process runs in the background.

---

**Important Considerations for Cost Optimization:**

* **VM Size (`--size`):** The VM size is the most significant factor affecting cost. Always choose the smallest size that meets your workload requirements. The `B-series` VMs (`Standard_B1ls`, `Standard_B1ms`, etc.) are designed for burstable workloads and are the most cost-effective for intermittent use.
* **Location (`--location`):** Azure pricing varies by region. Use `az account list-locations --query "[].name"` to see available regions and compare prices using the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/).
* **OS Disk Size (`--os-disk-size-gb`):** Reduce the disk size to the minimum necessary for your operating system and applications.
* **OS Disk Type (`--os-disk-type`):** `Standard_HDD_LRS` is the cheapest but slowest. `Standard_SSD_LRS` offers a good balance. Only use `Premium_SSD_LRS` for performance-critical applications.
* **Auto-shutdown:** For VMs not required 24/7 (e.g., dev/test environments), configure an auto-shutdown schedule in the Azure Portal or via CLI after creation (`az vm auto-shutdown`). This stops billing for compute resources when the VM is not running.
* **Deallocate VM:** When you're not actively using the VM, stop it (`az vm stop --name MyVM --resource-group MyResourceGroup`) and then `deallocate` it (`az vm deallocate --name MyVM --resource-group MyResourceGroup`). Deallocating stops billing for compute resources (vCPUs, RAM), but you will still be billed for disk storage.

</details>

---

<details>
<summary><strong>Task 3 – Configure Networking (NSG + Public IP) ✅</strong></summary>

✅ **Goal**: Allow HTTP traffic to your VM using a Network Security Group (NSG) rule.

---

## Understanding Network Security Groups (NSG)

A Network Security Group (NSG) acts as a virtual firewall for your VM, controlling inbound and outbound traffic based on rules. When you create a VM, Azure automatically creates an NSG and associates it with your VM's network interface or subnet.

## 1. Add a Rule to Allow HTTP Traffic (Port 80)

By default, an NSG might not allow incoming HTTP (web) traffic on port 80. You need to explicitly add a rule to permit this.

```bash
az network nsg rule create \
  --resource-group MyResourceGroup \
  --nsg-name MyVMNSG \
  --name AllowHTTP \
  --priority 1000 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --destination-port-ranges 80 \
  --source-address-prefixes "*" \
  --destination-address-prefixes "*" \
  --description "Allow inbound HTTP traffic on port 8080 for web application"
```

**Explanation for `az network nsg rule create`:**
* `--resource-group MyResourceGroup`: Specifies the name of the resource group where your NSG is located. This should be the same resource group as your VM.
* `--nsg-name MyVMNSG`: Specifies the name of the Network Security Group to which you want to add the rule. When you create a VM, Azure typically names the NSG after the VM (e.g., `MyVM-nsg` or `MyVMNSG`). You might need to verify the exact NSG name associated with your VM. You can find it by listing network interfaces (`az network nic list`) or directly listing NSGs in the resource group (`az network nsg list --resource-group MyResourceGroup`).
* `--name AllowHTTP`: Provides a unique name for the new security rule. Choose a descriptive name.
* `--priority 1000`: Sets the priority of the rule. Rules are processed in numerical order (lowest number first). Ensure your rule's priority is lower than any Deny rules that might block port 80 (e.g., the default "DenyAllInbound" rule usually has a high priority like 65500).
* `--direction Inbound`: Specifies that this rule applies to incoming traffic to your VM.
* `--access Allow`: Defines the action for traffic matching this rule – in this case, to allow it.
* `--protocol Tcp`: Specifies the network protocol to which this rule applies. HTTP typically uses TCP.
* `--destination-port-ranges 80`: Specifies the destination port(s) for the traffic. Here, we specify port 80, which is the standard port for unencrypted HTTP traffic.
* `--source-address-prefixes "*" `: Defines the source IP address range from which traffic is allowed. `*` means allow traffic from any source IP address. For production environments, it's recommended to restrict this to known IP ranges for better security.
* `--destination-address-prefixes "*"`: Defines the destination IP address range. `*` means allow traffic to any destination IP address within the NSG's scope (typically your VM's private IP).
* `--description "Allow inbound HTTP traffic on port 8080 for web application"`: Some description of the rule

---

## 2. Show Public IP Address Details

To connect to your VM from the internet (e.g., via SSH or to access a web server), you need its public IP address.

```bash
az network public-ip show \
  --resource-group MyResourceGroup \
  --name MyVMIP \
  --query ipAddress \
  --output tsv
```

**Explanation for `az network public-ip show`:**
* `--resource-group MyResourceGroup`: Specifies the resource group where your public IP address resource is located.
* `--name MyVMIP`: Specifies the name of the public IP address resource. When you create a VM with a public IP, Azure usually names the public IP resource after the VM (e.g., `MyVMIP` or `MyVM-ip`).
* `--query ipAddress`: This is a JMESPath query that extracts only the `ipAddress` field from the output. This is useful when you just need the IP address without all other details.
* `--output tsv`: Formats the output as tab-separated values, making it easy to copy just the IP address.

---

## 3. List Network Interfaces (and find NSG name)

If you're unsure about the exact NSG name associated with your VM, or if you want to inspect network interface configurations, you can list them. The NSG is typically linked to the VM's Network Interface Card (NIC).

```bash
az network nic list \
  --resource-group MyResourceGroup \
  --query "[?starts_with(name, 'MyVM')].{Name:name, PublicIp:ipConfigurations[0].publicIpAddress.id, NSG:networkSecurityGroup.id}" \
  --output table
```

**Explanation for `az network nic list`:**
* `--resource-group MyResourceGroup`: Filters the list to show only NICs within your specified resource group.
* `--query "[?starts_with(name, 'MyVM')].{Name:name, PublicIp:ipConfigurations[0].publicIpAddress.id, NSG:networkSecurityGroup.id}"`: This is a powerful JMESPath query to filter and format the output:
    * `[?starts_with(name, 'MyVM')]`: Filters the list of NICs to only include those whose names start with 'MyVM' (assuming your VM's NIC will be named something like `MyVMNic`).
    * `. {Name:name, PublicIp:ipConfigurations[0].publicIpAddress.id, NSG:networkSecurityGroup.id}`: Selects specific properties for display and renames them for readability:
        * `Name:name`: Displays the NIC's name.
        * `PublicIp:ipConfigurations[0].publicIpAddress.id`: Tries to extract the ID of the associated public IP address.
        * `NSG:networkSecurityGroup.id`: Extracts the ID of the associated Network Security Group. From this ID, you can infer the NSG's name (it's the last part of the ID after `/`).
* `--output table`: Displays the results in a readable table format.

**How to find the exact NSG name from the output of `az network nic list`:**
The `NSG` column will show a full Azure resource ID path (e.g., `/subscriptions/.../resourceGroups/MyResourceGroup/providers/Microsoft.Network/networkSecurityGroups/MyVM-nsg`). The part after the last `/` is the actual NSG name (e.g., `MyVM-nsg`). Use this name in the `az network nsg rule create` command.

</details>

---

<details>
<summary><strong>Task 4 – Deploy a Simple Web App to the VM ✅</strong></summary>

✅ **Goal**: SSH into your VM and deploy a small web server using Flask.

---

```bash
ssh azureuser@<your-public-ip>
```

Verify installation:

```bash
docker --version
docker compose version
```

### 4️⃣ Copy Project Files to VM  
Transfer your project files using **`scp`**:

```bash
scp -r ./project azureuser@<public-ip>:~/week8
```

🔹 **Ensure SSH is working before running this command**.  
🔹 If using an SSH key, you might need `-i ~/.ssh/id_rsa` if not using the default key.

### 5️⃣ Deploy the App  

```bash
cd week8
sudo docker compose up -d
```

🔹 This starts the application in the background (`-d` = detached mode).  
🔹 Ensure **`docker-compose.yml`** exists inside the `week8` directory.

### 6️⃣ Expose the Application on Public Port  
By default, Azure virtual machines are protected by **Network Security Groups (NSGs)** that block all **incoming** traffic except for specific allowed ports.  
To access your app (e.g., running on port `8000`) **from the internet**, you need to manually allow inbound traffic to that port.

### ✅ Steps to open port 8000:

```yaml
1. Go to Azure Portal → your VM → Networking tab.
2. Under Inbound port rules, click + Add inbound port rule.
3. Fill the form as follows:
   - Source: Any  
     → Allows connections from all external IP addresses (can restrict for security).
   - Source port ranges: *  
     → Accepts traffic from any source port (standard).
   - Destination: Any  
     → Refers to any destination IP within the VM (standard).
   - Destination port ranges: 8000  
     → The public port your container is exposed on (e.g., Nginx running on port 8080).
   - Protocol: TCP  
     → Most web traffic uses TCP; this is the common setting for web apps.
   - Action: Allow  
     → Approves traffic instead of denying it.
   - Priority: 1010  
     → Determines rule evaluation order; lower = higher priority. Must be unique.
   - Name: Allow-Web-8080 (or any descriptive name)
4. Click Add to apply the rule.
```

---

### then verify with:

```bash
curl http://<public-ip>:3000
```

---

</details>

---

<details>
<summary><strong>Task 5 – Use Storage Account (Optional Challenge) </strong></summary>

✅ **Goal**: Upload a file to Azure Storage using the CLI.

---

```bash
az storage account create \
  --name mystorageacct \
  --resource-group myResourceGroup \
  --location eastus \
  --sku Standard_LRS

az storage container create \
  --name mycontainer \
  --account-name mystorageacct

az storage blob upload \
  --account-name mystorageacct \
  --container-name mycontainer \
  --name sample.txt \
  --file ./sample.txt
```

</details>

---

<details>
<summary><strong>Task 6 – Script the Entire Deployment </strong></summary>

✅ **Goal**: Write a bash script that automates all steps above.

---

Include in your script:
- Resource group + VM creation
- NSG rule addition
- App deployment
- Bonus: cleanup logic

Example (partial):

[bash]
#!/bin/bash

az group create --name myResourceGroup --location eastus

az vm create \
  --resource-group myResourceGroup \
  --name myVM \
  --image UbuntuLTS \
  --admin-username azureuser \
  --generate-ssh-keys
[/bash]

</details>

---

<details>
<summary><strong>Task 7 – Combine CI/CD and Azure Deployment (Advanced) </strong></summary>

✅ **Goal**: Automate deployment using GitHub Actions.

---

### 🔐 Use GitHub Secrets:

- `AZURE_USER`
- `AZURE_HOST`
- `AZURE_PRIVATE_KEY`

### 🧪 Sample Commands:

[bash]
scp ./app.py docker-compose.yml ${{ secrets.AZURE_USER }}@${{ secrets.AZURE_HOST }}:~/

ssh -i ~/.ssh/id_rsa ${{ secrets.AZURE_USER }}@${{ secrets.AZURE_HOST }} 'docker compose up -d'
[/bash]

💡 Make sure your VM is listening on a public port and your NSG allows access.

</details>
