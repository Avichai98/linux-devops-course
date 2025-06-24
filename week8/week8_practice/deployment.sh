#!/bin/bash

set -e

# This script is used to deploy the application

# ======= GLOBAL SETUP =======

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

# ======= AZURE SETUP =======

create_resource_group() {
  echo "Creating resource group..."
  az group create \
      --name "$resource_group_name" \
      --location westeurope
  echo "Resource group '$resource_group_name' created successfully."
}

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

create_vm() {
  echo "Creating VM..."

  if ! az group exists --name "$resource_group_name"; then
    echo "Resource group '$resource_group_name' does not exist."
    exit 1
  fi

  az vm create \
    --resource-group "$resource_group_name" \
    --name "$vm_name" \
    --image UbuntuLTS \
    --admin-username "$vm_admin_username" \
    --ssh-key-values ~/.ssh/mynewkey.pub \
    --location westeurope \
    --size Standard_B1ls \
    --os-disk-size-gb 30 \
    --storage-sku Standard_LRS \
    --public-ip-sku Standard \
    --no-wait

  echo "VM '$vm_name' created successfully in resource group '$resource_group_name'."
}

create_nsg_rule() {
  echo "Creating Network Security Group (NSG) rule..."
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
}

associate_nsg() {
  echo "Associating NSG with VM's network interface..."
  az network nic update \
    --name "${vm_name}VMNic" \
    --resource-group "$resource_group_name" \
    --network-security-group "$nsg_name"
}

get_public_ip() {
  public_ip=$(az vm show \
    --resource-group "$resource_group_name" \
    --name "$vm_name" \
    --show-details \
    --query "publicIps" \
    --output tsv)

  echo "Public IP address of the VM: $public_ip"
}

# ======= DEPLOYMENT =======

transfer_files() {
  echo "Transferring application files to the VM..."
  scp -i ~/.ssh/mynewkey -r ./ "$vm_admin_username@$public_ip":~/week8
}

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
    docker compose up -d
EOF

  echo "Application is running. You can access it at http://$public_ip:3000"
}

cleanup_resources() {
  read -p "Do you want to delete all created resources? (y/n): " cleanup
  if [[ "$cleanup" == "y" ]]; then
    echo "Deleting resource group '$resource_group_name'..."
    az group delete --name "$resource_group_name" --yes --no-wait
    echo "Cleanup initiated."
  fi
}

# ======= MAIN EXECUTION =======

main() {
  prompt_inputs
  login_azure
  create_resource_group
  generate_ssh_key_if_needed
  create_vm
  create_nsg_rule
  associate_nsg
  get_public_ip
  transfer_files
  deploy_app
  cleanup_resources
}

main
# End of script
