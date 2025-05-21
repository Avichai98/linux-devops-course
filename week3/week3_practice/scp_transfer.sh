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
