# 📘 Week 3 – DevOps Daily Practice Tasks

 📁 All scripts and work should be placed in the `week3_practice/` folder as required.

### **🔹 Task 1: Display Network Info & Open Ports**
<details>
<summary>Expand Task 1</summary>

---


## 🚀 Script Overview (`network.sh`)

```bash
#!/bin/bash

# Show interfaces and IP addresses
ip a

# Show TCP/UDP listening ports
ss -tuln

# NOTE:
# If you see a line like "tcp LISTEN 0 4096 127.0.0.1:22",
# it means the SSH service is running and listening only on the loopback interface (localhost).
# This means you can SSH into this machine from itself (127.0.0.1), but not from other machines.

```

---

## 📊 Sample Port Table Output (Formatted)

| Netid | State   | Recv-Q | Send-Q | Local Address:Port     | Peer Address:Port | Explanation                                        |
|-------|---------|--------|--------|-------------------------|-------------------|----------------------------------------------------|
| udp   | UNCONN  | 0      | 0      | 127.0.0.54:53           | 0.0.0.0:*         | DNS service listening on loopback (systemd-resolved) |
| udp   | UNCONN  | 0      | 0      | 127.0.0.53%lo:53        | 0.0.0.0:*         | Another DNS server on loopback `lo` interface      |
| udp   | UNCONN  | 0      | 0      | 127.0.0.1:323           | 0.0.0.0:*         | NTP (or Chronyd) on local IPv4 loopback            |
| udp   | UNCONN  | 0      | 0      | [::1]:323               | [::]:*            | NTP (or Chronyd) on local IPv6 loopback            |
| tcp   | LISTEN  | 0      | 511    | 127.0.0.1:38015         | 0.0.0.0:*         | Unknown service on local port 38015                |
| tcp   | LISTEN  | 0      | 4096   | 127.0.0.54:53           | 0.0.0.0:*         | TCP DNS server on loopback                         |
| tcp   | LISTEN  | 0      | 4096   | 127.0.0.53%lo:53        | 0.0.0.0:*         | Another TCP DNS socket on loopback interface `lo`  |
| tcp   | LISTEN  | 0      | 4096   | *:22                    | *:*               | SSH daemon is accepting connections from all interfaces |

---

### 🔍 Sample Row Explanation

Take this row for example:
```
tcp   LISTEN  0  4096  127.0.0.1:22  0.0.0.0:*
```
It means that the **SSH server is listening only on the local loopback address** (`127.0.0.1`) and is not accessible from outside the machine.

---

## 📘 Column Descriptions

| Column             | Meaning                                                                 |
|--------------------|-------------------------------------------------------------------------|
| `Netid`            | Network protocol (`tcp`, `udp`, etc.)                                   |
| `State`            | Connection state (`LISTEN`, `UNCONN`)                                   |
| `Recv-Q` / `Send-Q`| Number of bytes not yet received/sent                                   |
| `Local Address:Port` | The address and port the service is bound to                          |
| `Peer Address:Port`  | Remote address and port (for connections or listening wildcards)      |
| `Explanation`      | Human-readable description of the service and purpose                   |

---

</details>

### **🔹 Task 2: Generate SSH Key & Connect**
<details>
  <summary>Expand Task 2</summary>

```bash
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
function prompt_for_vm_details() {
  echo -e "${CYAN}Enter the VM username (e.g., azureuser):${RESET}"
  read username

  echo -e "${CYAN}Enter the VM public IP (e.g., 172.201.156.170):${RESET}"
  read vm_ip
}

# ========== Generate SSH key if it doesn't exist ==========
function generate_ssh_key() {
  if [ ! -f "$KEY_PATH" ]; then
    echo -e "${YELLOW}Generating new SSH key...${RESET}"
    ssh-keygen -t rsa -b 4096 -f "$KEY_PATH" -C "vm_access_key" -N ""
  else
    echo -e "${GREEN}SSH key already exists. Using existing key.${RESET}"
  fi
}

# ========== Start ssh-agent and add the SSH key ==========
function start_ssh_agent() {
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
function is_key_on_vm() {
  # This uses grep -F to search for the exact contents of the public key on the remote VM
  ssh "$username@$vm_ip" "grep -F -q \"$(cat $KEY_PATH.pub)\" ~/.ssh/authorized_keys" 2>/dev/null
}

# ========== Copy the public key to the VM using ssh-copy-id ==========
function copy_key_to_vm() {
  echo -e "${YELLOW}Copying SSH public key to the VM...${RESET}"
  ssh-copy-id "$username@$vm_ip"
}

# ========== Test if passwordless SSH connection is working ==========
function test_ssh_connection() {
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
function upload_key_with_azure_cli() {
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
function main() {
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

```
</details>

### **🔹 Task 3: Create an Azure VM**
<details>
  <summary>Expand Task 3</summary>

🔹 **Steps to create a VM using Azure CLI:**
```bash
az vm create \  # Creates a new virtual machine in Azure
  --resource-group devops_course \  # Specifies the resource group where the VM will be created
  --name LinuxLab \  # Sets the name of the virtual machine
  --image Ubuntu2204 \  # Uses the Ubuntu 22.04 LTS image as the OS for the VM
  --size Standard_B1s \  # Chooses the VM size (B1s is a small, low-cost instance type)
  --admin-username azureuser \  # Sets the administrator username for SSH login
  --generate-ssh-keys  # Automatically generates SSH keys if they don't exist, and uses them for authentication
```

✅ This ensures the VM is created and **SSH is accessible**.

</details>

### **🔹 Task 4: Remote File Transfer with SCP**
<details>
  <summary>Expand Task 4</summary>

```bash
#!/bin/bash

# ========== Color Definitions ==========
GREEN=$(tput setaf 2)     # Set text color to green (used for success messages)
RED=$(tput setaf 1)       # Set text color to red (used for error messages)
YELLOW=$(tput setaf 3)    # Set text color to yellow (used for progress/info)
CYAN=$(tput setaf 6)      # Set text color to cyan (used for prompts)
RESET=$(tput sgr0)        # Reset text formatting to default

# ========== Get VM Details ==========
echo -e "${CYAN}Enter VM username (e.g., azureuser):${RESET}"
read username          

echo -e "${CYAN}Enter VM public IP:${RESET}"
read vm_ip              

echo -e "${CYAN}Enter the filename to transfer:${RESET}"
read file_name       

# ========== Upload the file to the VM ==========
echo -e "${YELLOW}Uploading the file to the VM...${RESET}"

# 'scp' (secure copy) is used to copy files securely between local and remote machines using SSH
# Syntax: scp <source> <destination>
# "$file_name" → local file to upload
# "$username@$vm_ip:/home/$username/" → remote destination path (home directory on the VM)
scp "$file_name" "$username@$vm_ip:/home/$username/"

# ========== Verify the file exists on the VM ==========
echo -e "${YELLOW}Verifying the file on VM...${RESET}"

# 'ssh' opens a secure shell session to the remote VM
# The command inside the quotes is executed on the remote machine
# The test '[ -f /home/$username/$file_name ]' checks if the file exists on the remote VM
ssh "$username@$vm_ip" "[ -f /home/$username/$file_name ] && \
  echo -e '${GREEN}File exists on VM.${RESET}' || \
  echo -e '${RED}File NOT found on VM!${RESET}'"

# ========== Download the file back from the VM ==========
echo -e "${YELLOW}Downloading the file from the VM...${RESET}"


mkdir -p ./VM

# 'scp' again, but this time from remote to local
# Remote path: "$username@$vm_ip:/home/$username/$file_name"
# Local destination: "./VM/downloaded_$file_name"
scp "$username@$vm_ip:/home/$username/$file_name" "./VM/downloaded_$file_name"

# ========== Verify the downloaded file exists locally ==========
# '[ -f <path> ]' checks if the downloaded file exists locally
if [ -f "./VM/downloaded_$file_name" ]; then
    echo -e "${GREEN}File downloaded successfully!${RESET}"
else
    echo -e "${RED}File download failed!${RESET}"
fi
```
  </details>

### **🔹 Task 5: Run a Remote Command via SSH**
<details>
  <summary>Expand Task 5</summary>

```bash
#!/bin/bash

# ========== Color Definitions ==========
GREEN=$(tput setaf 2)  # Green text for success messages
RED=$(tput setaf 1)    # Red text for error messages
YELLOW=$(tput setaf 3) # Yellow text for process information
CYAN=$(tput setaf 6)   # Cyan text for user prompts
RESET=$(tput sgr0)     # Reset text formatting

# ========== Get VM Details ==========
echo -e "${CYAN}Enter VM username (e.g., azureuser):${RESET}"
read username

echo -e "${CYAN}Enter VM public IP:${RESET}"
read vm_ip

echo -e "${CYAN}Enter the command to run on the VM (e.g., 'uptime', 'df -h', 'ls -l /home/youruser'):${RESET}"
read remote_command

# ========== Check SSH access ==========
echo -e "${YELLOW}Checking SSH access...${RESET}"

# This attempts to connect via SSH without a password (using public key authentication).
# The option '-o PasswordAuthentication=no' forces it to fail if no key is available.
if ssh -o PasswordAuthentication=no "$username@$vm_ip" true; then
    echo -e "${GREEN}Passwordless SSH login is working.${RESET}"
else
    echo -e "${RED}SSH authentication required. Exiting.${RESET}"
    exit 1 # Exit script if SSH access isn't available without password
fi

# ========== Execute remote command and save output ==========
echo -e "${YELLOW}Executing command on VM...${RESET}"

# The '-t' option forces pseudo-terminal allocation (useful for interactive commands).
# 'tee' writes output to both terminal and a file ("remote_output.txt")
ssh -t "$username@$vm_ip" "$remote_command" | tee "remote_output.txt"

# ========== Set up SSH Tunnel for live access ==========
echo -e "${YELLOW}Setting up SSH tunnel for live output...${RESET}"

# This creates an SSH tunnel:
# -L 2222:localhost:22 → Forwards local port 2222 to remote port 22 (SSH on VM)
# -N → Tells SSH to not execute remote commands, just keep the tunnel open
# '&' → Runs the tunnel in the background
ssh -L 2222:localhost:22 "$username@$vm_ip" -N &
TUNNEL_PID=$! # Store the background process ID to close the tunnel later

# ========== Wait for user confirmation before closing ==========
echo -e "${CYAN}SSH tunnel is open on port 2222. Press [Enter] to close.${RESET}"
read # Wait for user to press Enter

kill "$TUNNEL_PID" # Terminate the background SSH tunnel
echo -e "${GREEN}SSH tunnel closed.${RESET}"
```

</details>

## 📁 Folder Structure

The following files are included in the `week3_practice/` directory:

```
week3_practice/
├── network.sh                # Task 1 - Show network info & ports
├── generate_ssh_key.sh       # Task 2 - SSH key generation & connection
├── scp_transfer.sh           # Task 4 - SCP upload/download
├── run_remote_command.sh     # Task 5 - Run remote commands via SSH
└── README.md                 # Documentation with explanations and code
```

