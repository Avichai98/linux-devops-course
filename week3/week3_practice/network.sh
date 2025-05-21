#!/bin/bash

# Script Name: network.sh
# Description: This script displays IP addresses and open/listening ports


# Show IP addresses of all network interfaces
echo "📡 Showing IP addresses of all network interfaces:"
echo "--------------------------------------------------"
ip a
echo ""

# Show open ports and listening services (TCP and UDP)
echo "🔌 Showing open ports and listening services:"
echo "--------------------------------------------"
ss -tuln
echo ""

# NOTE:
# If you see a line like "tcp LISTEN 0 4096 127.0.0.1:22",
# it means the SSH service is running and listening only on the loopback interface (localhost).
# This means you can SSH into this machine from itself (127.0.0.1), but not from other machines.
