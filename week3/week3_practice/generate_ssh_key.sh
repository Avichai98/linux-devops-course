#!/bin/bash

# ========== Color Definitions ==========
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)

# ========== SSH Key Path ==========
KEY_PATH="$HOME/.ssh/id_rsa"

# ========== Prompt for VM details ==========
prompt_for_vm_details() {
  echo -e "${CYAN}Enter the VM username (e.g., azureuser):${RESET}"
  read username

  echo -e "${CYAN}Enter the VM public IP (e.g., 172.201.156.170):${RESET}"
  read vm_ip
}

# ========== Generate SSH key if it doesn't exist ==========
generate_ssh_key() {
  if [ ! -f "$KEY_PATH" ]; then
    echo -e "${YELLOW}Generating new SSH key...${RESET}"
    ssh-keygen -t rsa -b 4096 -f "$KEY_PATH" -C "vm_access_key" -N ""
  else
    echo -e "${GREEN}SSH key already exists. Using existing key.${RESET}"
  fi
}

# ========== Start ssh-agent and add the SSH key ==========
start_ssh_agent() {
  # Start agent if not already running
  if [ -z "$SSH_AUTH_SOCK" ] || ! ssh-add -l &>/dev/null; then
    echo -e "${YELLOW}Starting ssh-agent...${RESET}"
    eval "$(ssh-agent -s)"
  fi

  # Add key to the agent
  echo -e "${YELLOW}Adding SSH key to agent...${RESET}"
  ssh-add "$KEY_PATH" || echo -e "${RED}⚠️ Could not add key to agent.${RESET}"
}

# ========== Check if the SSH key is already present on the VM ==========
is_key_on_vm() {
  # This uses grep -F to search for the exact contents of the public key on the remote VM
  ssh "$username@$vm_ip" "grep -F -q \"$(cat $KEY_PATH.pub)\" ~/.ssh/authorized_keys" 2>/dev/null
}

# ========== Copy the public key to the VM using ssh-copy-id ==========
copy_key_to_vm() {
  echo -e "${YELLOW}Copying SSH public key to the VM...${RESET}"
  ssh-copy-id "$username@$vm_ip"
}

# ========== Test if passwordless SSH connection is working ==========
test_ssh_connection() {
  echo -e "${YELLOW}Testing passwordless SSH connection...${RESET}"
  # Disable password prompt with PasswordAuthentication=no
  if ssh -o PasswordAuthentication=no "$username@$vm_ip" true; then
    echo -e "${GREEN}Passwordless SSH connection successful.${RESET}"
    return 0
  else
    echo -e "${RED}SSH connection failed.${RESET}"
    return 1
  fi
}

# ========== Upload the public key via Azure CLI (alternative method) ==========
upload_key_with_azure_cli() {
  echo -e "${CYAN}Enter your Azure VM name:${RESET}"
  read vm_name

  echo -e "${CYAN}Enter your Azure Resource Group:${RESET}"
  read resource_group

  echo -e "${YELLOW}Uploading public key via Azure CLI...${RESET}"
  az vm user update \
    --resource-group "$resource_group" \
    --name "$vm_name" \
    --username "$username" \
    --ssh-key-value "$(cat $KEY_PATH.pub)"
}

# ========== Main script logic ==========
main() {
  prompt_for_vm_details
  generate_ssh_key
  start_ssh_agent

  echo -e "${YELLOW}Checking if SSH key is already installed on VM...${RESET}"
  if is_key_on_vm; then
    echo -e "${GREEN}SSH key already exists on VM. Skipping key copy.${RESET}"
  else
    copy_key_to_vm
  fi

  if test_ssh_connection; then
    # Open an SSH session if the connection works
    ssh "$username@$vm_ip"
  else
    # Ask if user wants to use Azure CLI fallback
    echo -e "${CYAN}Would you like to upload your key via Azure CLI instead? (y/n)${RESET}"
    read answer
    if [[ "$answer" == "y" ]]; then
      upload_key_with_azure_cli
      ssh "$username@$vm_ip"
    fi
  fi
}

# ========== Execute main function ==========
main
