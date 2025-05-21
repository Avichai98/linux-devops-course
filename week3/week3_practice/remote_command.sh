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
