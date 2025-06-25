# Azure VM Deployment Project – Week 8

---

## Project Overview

This project demonstrates the deployment of a cloud infrastructure on Microsoft Azure using **Azure CLI** and a Bash deployment script. The infrastructure includes:

- Creation of a **Resource Group**  
- Provisioning a **Linux Ubuntu VM**  
- Network configuration with a **Network Security Group (NSG)** allowing HTTP and SSH traffic  
- Transfer and deployment of a simple web application using **Docker Compose**  
- Optional cleanup of resources

This project integrates theoretical knowledge with practical automation skills learned during the course.

---

## Architecture Diagram

Below is the infrastructure overview showing key components and their relationships:

- Virtual Machine (Ubuntu 22.04)  
- Public IP (static)  
- Network Interface Card (NIC) associated with NSG  
- Network Security Group allowing ports 22 (SSH) and 3000 (HTTP for the app)  

![Architecture Diagram](<week8_architecture_summary.png>)


---

## Deployment Script

The deployment is fully automated using the provided Bash script:

- Prompts for resource names and VM configuration  
- Checks and logs into Azure CLI  
- Creates resource group, VM, NSG, and NSG rules  
- Generates SSH key pair if missing  
- Transfers application files to VM using SCP  
- Installs Docker on the VM if not installed  
- Runs the application via Docker Compose  
- Prompts for optional cleanup (deletes resource group and all associated resources)

You can find the script here:  
`./deployment.sh`

---

## Detailed Script Explanation

### 1. Input and Azure Login

```bash
prompt_inputs() {
  read -p "Enter the name of the resource group: " resource_group_name
  read -p "Enter the name of the VM: " vm_name
  read -p "Enter the admin username for the VM: " vm_admin_username
  read -p "Enter the name of the Network Security Group (NSG): " nsg_name
}

login_azure() {
  if ! az account show &>/dev/null; then
    echo "You are not logged in to Azure. Please log in first."
    az login
  fi
}
```

- `read -p` prompts the user for input  
- `az account show` checks if logged in  
- `az login` opens browser login if needed

---

### 2. Resource Group Creation

```bash
create_resource_group() {
  echo "Creating resource group..."
  az group create \
      --name "$resource_group_name" \
      --location westeurope
  echo "Resource group '$resource_group_name' created successfully."
}
```

- Creates a resource group in Azure  
- `--location westeurope` specifies the Azure region

---

### 3. SSH Key Generation

```bash
generate_ssh_key_if_needed() {
  ssh_key_path="$HOME/.ssh/mynewkey"

  if [ ! -f "$ssh_key_path" ]; then
    echo "SSH key not found at $ssh_key_path – generating..."
    if ssh-keygen -t rsa -b 4096 -f "$ssh_key_path" -N ""; then
      echo "SSH key generated successfully."
    else
      echo "Failed to generate SSH key. Exiting."
      exit 1
    fi
  else
    echo "Using existing SSH key at $ssh_key_path"
  fi
}
```

- Checks if SSH key exists  
- If not, generates a 4096-bit RSA SSH key without passphrase
- -t rsa – Specifies RSA key type
- -b 4096 – 4096-bit key length for stronger security
- -f – Output file for the key
- -N "" – Empty passphrase (no password required when using the key)

---

### 4. Virtual Machine Creation

```bash
create_vm() {
  echo "Creating VM..."

  if ! az group exists --name "$resource_group_name"; then
    echo "Resource group '$resource_group_name' does not exist."
    exit 1
  fi

  az vm create \
    --resource-group "$resource_group_name" \
    --name "$vm_name" \
    --image Ubuntu2204 \
    --admin-username "$vm_admin_username" \
    --ssh-key-values ~/.ssh/mynewkey.pub \
    --location westeurope \
    --size Standard_B1ls \
    --os-disk-size-gb 30 \
    --storage-sku Standard_LRS \
    --public-ip-sku Standard \

  echo "VM '$vm_name' created successfully in resource group '$resource_group_name'."
}
```
 
- Uses the SSH public key for login  
- -image – Specifies Ubuntu 22.04 as the OS image
- -size – Defines VM specs (Standard_B1ls = 1 vCPU, low RAM)
- -ssh-key-values – Sets up key-based SSH authentication
- -os-disk-size-gb – Operating system disk size
- -public-ip-sku – Type of public IP address:
  - Standard is static and reliable across reboots (good for production)
  - Basic is dynamic and can change after stop/start cycles

---

### 5. Network Security Group (NSG)

```bash
get_public_ip() {
  public_ip=$(az vm show \
    --resource-group "$resource_group_name" \
    --name "$vm_name" \
    --show-details \
    --query "publicIps" \
    --output tsv)

  echo "Public IP address of the VM: $public_ip"
}
```

- az vm show – Displays information about the VM
- --show-details – Includes networking, storage, and status information
- --query "publicIps" – Extracts just the public IP using JMESPath
- --output tsv – Returns the result in plain text (tab-separated)

```bash
setup_swap() {
  echo "Checking for existing swap..."
  ssh -i ~/.ssh/mynewkey "$vm_admin_username@$public_ip" bash -s << 'EOF'
if swapon --show | grep -q "/swapfile"; then
  echo "Swapfile already exists and is active."
else
  echo "Creating 1GB swapfile at /swapfile..."
  sudo fallocate -l 1G /swapfile
  sudo chmod 600 /swapfile
  sudo mkswap /swapfile
  sudo swapon /swapfile
  echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
  echo "Swapfile created and enabled."
fi
echo "Current swap status:"
free -h
EOF
}
```

- Swap space is added if none exists (1GB swapfile)
- Helps avoid memory crashes in low-memory VMs like Standard_B1ls
- Command uses a heredoc (EOF) to run multiple commands via SSH

#### EOF explanation:

 This syntax allows sending a block of commands into a remote session. Everything between << 'EOF' and the closing EOF is executed on the remote machine.


```bash
create_nsg() {
  az network nsg create \
    --resource-group "$resource_group_name" \
    --name "$nsg_name" \
    --location westeurope
}
```

- Creates the Network Security Group (NSG), which acts as a virtual firewall

```bash
create_nsg_rule() {
  echo "Creating Network Security Group (NSG) rules..."
  az network nsg rule create \
    --resource-group "$resource_group_name" \
    --nsg-name "$nsg_name" \
    --name AllowSSH \
    --priority 100 \
    --direction Inbound \
    --access Allow \
    --protocol Tcp \
    --destination-port-ranges 22 \
    --source-address-prefixes "*" \
    --destination-address-prefixes "*" \
    --description "Allow SSH"

  az network nsg rule create \
    --resource-group "$resource_group_name" \
    --nsg-name "$nsg_name" \
    --name AllowHTTP \
    --priority 1000 \
    --direction Inbound \
    --access Allow \
    --protocol Tcp \
    --destination-port-ranges 3000 \
    --source-address-prefixes "*" \
    --destination-address-prefixes "*" \
    --description "Allow inbound HTTP traffic on port 3000"
  echo "NSG rule created."

  az network nsg rule create \
    --resource-group "$resource_group_name" \
    --nsg-name "$nsg_name" \
    --name AllowHTTP \
    --priority 1001 \
    --direction Inbound \
    --access Allow \
    --protocol Tcp \
    --destination-port-ranges 80 \
    --source-address-prefixes "*" \
    --destination-address-prefixes "*" \
    --description "Allow inbound HTTP traffic on port 80"
  echo "NSG rule created."
}
```

- --priority – Lower value = higher priority
- --direction – Inbound/Outbound traffic
- --access – Whether to Allow or Deny the traffic
- --protocol – TCP or UDP
- --destination-port-ranges – Ports to open (3000 for app, 22 for SSH)

---

### 6. Associate NSG with VM's NIC

```bash
associate_nsg() {
  az network nic update \
    --name "${vm_name}VMNic" \
    --resource-group "$resource_group_name" \
    --network-security-group "$nsg_name"
}
```

- Binds the NSG (firewall rules) to the VM’s network interface card (NIC)
- Ensures all incoming/outgoing traffic follows NSG rules

---

### 7. Setup File Share

```bash
setup_file_share() {
  echo "Creating Azure File Share..."

  storage_account="${resource_group_name}stor$RANDOM"

  az storage account create \
   --name "$storage_account" \
   --resource-group "$resource_group_name" \
   --location westeurope \
   --sku Standard_LRS \
   --kind StorageV2 \
   --access-tier Hot \
   --enable-hierarchical-namespace false \
   --allow-blob-public-access true \
   --min-tls-version TLS1_2

  az storage share create \
    --name appshare \
    --account-name "$storage_account"

  storage_key=$(az storage account keys list \
    --account-name "$storage_account" \
    --query "[0].value" -o tsv)

  echo "Mounting file share on VM..."
  ssh -i ~/.ssh/mynewkey "$vm_admin_username@$public_ip" << EOF
    sudo apt update && sudo apt install -y cifs-utils
    sudo mkdir -p /mnt/appshare
    sudo mount -t cifs //$storage_account.file.core.windows.net/appshare /mnt/appshare \
      -o vers=3.0,username=$storage_account,password=$storage_key,dir_mode=0777,file_mode=0777,serverino
EOF
}
```

#### Explanation for `az storage account create`:
* `--name`: A unique name for your storage account (must be globally unique).
* `--resource-group`: The resource group to which the storage account will belong.
* `--location`: Azure region (e.g., `eastus`).
* `--sku`: Pricing tier (`Standard_LRS` for standard locally redundant storage).
* `--kind`: Type of storage account. `StorageV2` is the most common.
* `--access-tier`: Either `Hot` (frequent access) or `Cool` (infrequent access).
* `--enable-hierarchical-namespace`: Set to `true` to enable Data Lake features (not needed here).
* `--allow-blob-public-access`: If `true`, allows anonymous public access to blobs.
* `--min-tls-version`: Enforces minimum TLS version for connections.

---

### 8. Transfer Application Files and Deploy App

```bash
transfer_files() {
  echo "Transferring application files to the VM..."
  scp -i ~/.ssh/mynewkey -r ./app "$vm_admin_username@$public_ip":~/week8
}
```

- scp – Secure copy of local files to the remote VM
- -i – Path to private key
- -r – Recursive copy of entire directory

```bash
deploy_app() {
  echo "Connecting to VM and deploying the application..."
  ssh -i ~/.ssh/mynewkey "$vm_admin_username@$public_ip" << EOF
    echo "Connected to VM."

    if ! command -v docker &> /dev/null; then
      echo "Installing Docker..."
      sudo apt update
      sudo apt install -y ca-certificates curl gnupg
      sudo install -m 0755 -d /etc/apt/keyrings
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
      echo "deb [signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
      sudo apt update
      sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    else
      echo "Docker is already installed."
    fi

    echo "Running the application..."
    cd ~/week8 || exit
    sudo docker compose up -d
EOF

  echo "Application is running. You can access it at http://$public_ip:3000"
}
```

- SSH to VM to install Docker if missing  
- Runs docker compose up -d to start the app as a background container

---

### 9. Setup Reverse Proxy

```bash
setup_reverse_proxy() {
  echo "Installing and configuring NGINX as reverse proxy..."

  ssh -i ~/.ssh/mynewkey "$vm_admin_username@$public_ip" << 'EOF'
    set -e
    sudo apt update
    sudo apt install -y nginx

    sudo tee /etc/nginx/sites-available/reverse-proxy > /dev/null << 'EOL'
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOL

    sudo ln -sf /etc/nginx/sites-available/reverse-proxy /etc/nginx/sites-enabled/default
    sudo nginx -t && sudo systemctl restart nginx

    echo "NGINX reverse proxy is now running at http://$public_ip"
EOF
}
```

- sudo tee /etc/nginx/sites-available/reverse-proxy > /dev/null << 'EOL' –
Creates a new NGINX config file named reverse-proxy by writing the following block into it.

- server { ... } –
Defines a virtual server that listens on port 80 and proxies requests to the local app running on port 3000.

- listen 80; –
Listens for incoming HTTP traffic on port 80 (default web traffic port).

- server_name _; –
The underscore is a wildcard that matches any domain name or IP.

- location / { ... } –
Handles all requests sent to / by forwarding them.

- proxy_pass http://localhost:3000; –
Forwards incoming traffic to the local service (your app) running on port 3000.

- proxy_http_version 1.1; –
Sets HTTP version used for proxying to 1.1 (needed for WebSocket support).

- proxy_set_header –
Sets headers required for proper forwarding of requests, especially for WebSocket upgrades.

- sudo ln -sf /etc/nginx/sites-available/reverse-proxy /etc/nginx/sites-enabled/default –
Enables the new config by replacing the default site with a symlink to reverse-proxy.

- sudo nginx -t && sudo systemctl restart nginx –
Tests the new NGINX config for syntax errors and restarts NGINX to apply changes.

---

### 10. Cleanup Resources

```bash
cleanup_resources() {
  read -p "Do you want to delete all created resources? (y/n): " cleanup
  if [[ "$cleanup" == "y" ]]; then
    echo "Deleting resource group '$resource_group_name'..."
    az group delete --name "$resource_group_name" --yes --no-wait
    echo "Cleanup initiated."
  fi
}
```

- Prompts the user to delete all Azure resources created in this run

---

##  Notes and Tips

- The script is **idempotent** — safe to rerun with the same resource names (may overwrite)  
- The VM is created in the **westeurope** region; change `--location` if needed  
- The NSG opens ports **22** (SSH) and **3000** (your app) only  
- Ensure your local app directory has a valid `docker-compose.yml` and application files  
- SSH key is generated once and reused; you can change the key path in the script if needed  
- Public IP is retrieved dynamically after VM creation and used for SSH and app access  

---

## Health Check Script
[healthcheck.sh](../healthcheck.sh)

## Logging

All deployment steps are logged using this command:

```bash
log_file="deployment_log.md"
exec > >(tee -a "$log_file") 2>&1
```

- exec – Replaces the current output streams
- tee -a – Appends output to the file while showing it in terminal
- 2>&1 – Redirects standard error to standard output
- Useful for tracking issues or providing evidence of completed steps

## 📁 Azure File Share – Persistent Storage

- Creates a Storage Account (`--sku Standard_LRS`) and `appshare` file share.
- Retrieves storage key and mounts it on the VM at `/mnt/appshare` using CIFS.
- Ensures persistent storage outside of the VM lifecycle.

---

## 🌐 Reverse Proxy via NGINX & Custom Domain

The script configures NGINX on the VM to act as a reverse proxy:

- Installs `nginx` and updates `sites-available/default` config.
- Proxies `http://YOUR_DOMAIN` to `http://localhost:3000`.
- Must replace `YOUR_DOMAIN` with your purchased domain.
- Ensure DNS A-record points the domain to the VM’s IP.
- Additional NSG rule created to open port 80.

---