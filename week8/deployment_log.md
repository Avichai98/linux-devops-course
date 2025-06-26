Enter the name of the resource group: Enter the name of the VM: Enter the admin username for the VM: Enter the name of the Network Security Group (NSG): Creating resource group...
{
  "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test",
  "location": "westeurope",
  "managedBy": null,
  "name": "test",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}
Resource group 'test' created successfully.
Using existing SSH key at /home/avichai98/.ssh/mynewkey
Creating VM...
true
Selecting "uksouth" may reduce your costs. The region you've selected may cost more for the same services. You can disable this message in the future with the command "az config set core.display_region_identified=false". Learn more at https://go.microsoft.com/fwlink/?linkid=222571 

{
  "fqdns": "",
  "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Compute/virtualMachines/avichai",
  "location": "westeurope",
  "macAddress": "7C-ED-8D-5C-62-C0",
  "powerState": "VM running",
  "privateIpAddress": "10.0.0.4",
  "publicIpAddress": "4.180.91.175",
  "resourceGroup": "test",
  "zones": ""
}
VM 'avichai' created successfully in resource group 'test'.
Public IP address of the VM: 4.180.91.175
Checking for existing swap...
Warning: Permanently added '4.180.91.175' (ED25519) to the list of known hosts.
Creating 1GB swapfile at /swapfile...
Setting up swapspace version 1, size = 1024 MiB (1073737728 bytes)
no label, UUID=25533c21-ee4d-4748-861a-70d4f1179bf6
/swapfile none swap sw 0 0
Swapfile created and enabled.
Current swap status:
               total        used        free      shared  buff/cache   available
Mem:           345Mi       218Mi        10Mi       3.0Mi       116Mi       103Mi
Swap:          1.0Gi          0B       1.0Gi
Creating Network Security Group (NSG)...
{
  "NewNSG": {
    "defaultSecurityRules": [
      {
        "access": "Allow",
        "description": "Allow inbound traffic from all VMs in VNET",
        "destinationAddressPrefix": "VirtualNetwork",
        "destinationAddressPrefixes": [],
        "destinationPortRange": "*",
        "destinationPortRanges": [],
        "direction": "Inbound",
        "etag": "W/\"3c2bfd0c-199c-43d6-ab29-0a3b873817dd\"",
        "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/week8/defaultSecurityRules/AllowVnetInBound",
        "name": "AllowVnetInBound",
        "priority": 65000,
        "protocol": "*",
        "provisioningState": "Succeeded",
        "resourceGroup": "test",
        "sourceAddressPrefix": "VirtualNetwork",
        "sourceAddressPrefixes": [],
        "sourcePortRange": "*",
        "sourcePortRanges": [],
        "type": "Microsoft.Network/networkSecurityGroups/defaultSecurityRules"
      },
      {
        "access": "Allow",
        "description": "Allow inbound traffic from azure load balancer",
        "destinationAddressPrefix": "*",
        "destinationAddressPrefixes": [],
        "destinationPortRange": "*",
        "destinationPortRanges": [],
        "direction": "Inbound",
        "etag": "W/\"3c2bfd0c-199c-43d6-ab29-0a3b873817dd\"",
        "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/week8/defaultSecurityRules/AllowAzureLoadBalancerInBound",
        "name": "AllowAzureLoadBalancerInBound",
        "priority": 65001,
        "protocol": "*",
        "provisioningState": "Succeeded",
        "resourceGroup": "test",
        "sourceAddressPrefix": "AzureLoadBalancer",
        "sourceAddressPrefixes": [],
        "sourcePortRange": "*",
        "sourcePortRanges": [],
        "type": "Microsoft.Network/networkSecurityGroups/defaultSecurityRules"
      },
      {
        "access": "Deny",
        "description": "Deny all inbound traffic",
        "destinationAddressPrefix": "*",
        "destinationAddressPrefixes": [],
        "destinationPortRange": "*",
        "destinationPortRanges": [],
        "direction": "Inbound",
        "etag": "W/\"3c2bfd0c-199c-43d6-ab29-0a3b873817dd\"",
        "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/week8/defaultSecurityRules/DenyAllInBound",
        "name": "DenyAllInBound",
        "priority": 65500,
        "protocol": "*",
        "provisioningState": "Succeeded",
        "resourceGroup": "test",
        "sourceAddressPrefix": "*",
        "sourceAddressPrefixes": [],
        "sourcePortRange": "*",
        "sourcePortRanges": [],
        "type": "Microsoft.Network/networkSecurityGroups/defaultSecurityRules"
      },
      {
        "access": "Allow",
        "description": "Allow outbound traffic from all VMs to all VMs in VNET",
        "destinationAddressPrefix": "VirtualNetwork",
        "destinationAddressPrefixes": [],
        "destinationPortRange": "*",
        "destinationPortRanges": [],
        "direction": "Outbound",
        "etag": "W/\"3c2bfd0c-199c-43d6-ab29-0a3b873817dd\"",
        "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/week8/defaultSecurityRules/AllowVnetOutBound",
        "name": "AllowVnetOutBound",
        "priority": 65000,
        "protocol": "*",
        "provisioningState": "Succeeded",
        "resourceGroup": "test",
        "sourceAddressPrefix": "VirtualNetwork",
        "sourceAddressPrefixes": [],
        "sourcePortRange": "*",
        "sourcePortRanges": [],
        "type": "Microsoft.Network/networkSecurityGroups/defaultSecurityRules"
      },
      {
        "access": "Allow",
        "description": "Allow outbound traffic from all VMs to Internet",
        "destinationAddressPrefix": "Internet",
        "destinationAddressPrefixes": [],
        "destinationPortRange": "*",
        "destinationPortRanges": [],
        "direction": "Outbound",
        "etag": "W/\"3c2bfd0c-199c-43d6-ab29-0a3b873817dd\"",
        "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/week8/defaultSecurityRules/AllowInternetOutBound",
        "name": "AllowInternetOutBound",
        "priority": 65001,
        "protocol": "*",
        "provisioningState": "Succeeded",
        "resourceGroup": "test",
        "sourceAddressPrefix": "*",
        "sourceAddressPrefixes": [],
        "sourcePortRange": "*",
        "sourcePortRanges": [],
        "type": "Microsoft.Network/networkSecurityGroups/defaultSecurityRules"
      },
      {
        "access": "Deny",
        "description": "Deny all outbound traffic",
        "destinationAddressPrefix": "*",
        "destinationAddressPrefixes": [],
        "destinationPortRange": "*",
        "destinationPortRanges": [],
        "direction": "Outbound",
        "etag": "W/\"3c2bfd0c-199c-43d6-ab29-0a3b873817dd\"",
        "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/week8/defaultSecurityRules/DenyAllOutBound",
        "name": "DenyAllOutBound",
        "priority": 65500,
        "protocol": "*",
        "provisioningState": "Succeeded",
        "resourceGroup": "test",
        "sourceAddressPrefix": "*",
        "sourceAddressPrefixes": [],
        "sourcePortRange": "*",
        "sourcePortRanges": [],
        "type": "Microsoft.Network/networkSecurityGroups/defaultSecurityRules"
      }
    ],
    "etag": "W/\"3c2bfd0c-199c-43d6-ab29-0a3b873817dd\"",
    "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/week8",
    "location": "westeurope",
    "name": "week8",
    "provisioningState": "Succeeded",
    "resourceGroup": "test",
    "resourceGuid": "ae2dbe61-53e8-4730-aa63-4dd97fa8b8db",
    "securityRules": [],
    "type": "Microsoft.Network/networkSecurityGroups"
  }
}
NSG 'week8' created successfully in resource group 'test'.
Creating Network Security Group (NSG) rules...
{
  "access": "Allow",
  "description": "Allow SSH",
  "destinationAddressPrefix": "*",
  "destinationAddressPrefixes": [],
  "destinationPortRange": "22",
  "destinationPortRanges": [],
  "direction": "Inbound",
  "etag": "W/\"ccfd7af6-ccf2-42ad-b741-c272d29d5e75\"",
  "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/week8/securityRules/AllowSSH",
  "name": "AllowSSH",
  "priority": 100,
  "protocol": "Tcp",
  "provisioningState": "Succeeded",
  "resourceGroup": "test",
  "sourceAddressPrefix": "*",
  "sourceAddressPrefixes": [],
  "sourcePortRange": "*",
  "sourcePortRanges": [],
  "type": "Microsoft.Network/networkSecurityGroups/securityRules"
}
{
  "access": "Allow",
  "description": "Allow inbound HTTP traffic on port 3000",
  "destinationAddressPrefix": "*",
  "destinationAddressPrefixes": [],
  "destinationPortRange": "3000",
  "destinationPortRanges": [],
  "direction": "Inbound",
  "etag": "W/\"6cc1bbdd-b011-410e-bceb-6c6579d4d88a\"",
  "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/week8/securityRules/AllowHTTP",
  "name": "AllowHTTP",
  "priority": 1000,
  "protocol": "Tcp",
  "provisioningState": "Succeeded",
  "resourceGroup": "test",
  "sourceAddressPrefix": "*",
  "sourceAddressPrefixes": [],
  "sourcePortRange": "*",
  "sourcePortRanges": [],
  "type": "Microsoft.Network/networkSecurityGroups/securityRules"
}
NSG rule created.
{
  "access": "Allow",
  "description": "Allow inbound HTTP traffic on port 80",
  "destinationAddressPrefix": "*",
  "destinationAddressPrefixes": [],
  "destinationPortRange": "80",
  "destinationPortRanges": [],
  "direction": "Inbound",
  "etag": "W/\"454fd144-31a2-417f-9918-f34766c064ca\"",
  "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/week8/securityRules/AllowHTTP",
  "name": "AllowHTTP",
  "priority": 1001,
  "protocol": "Tcp",
  "provisioningState": "Succeeded",
  "resourceGroup": "test",
  "sourceAddressPrefix": "*",
  "sourceAddressPrefixes": [],
  "sourcePortRange": "*",
  "sourcePortRanges": [],
  "type": "Microsoft.Network/networkSecurityGroups/securityRules"
}
NSG rule created.
Associating NSG with VM's network interface...
{
  "auxiliaryMode": "None",
  "auxiliarySku": "None",
  "disableTcpStateTracking": false,
  "dnsSettings": {
    "appliedDnsServers": [],
    "dnsServers": [],
    "internalDomainNameSuffix": "vcye4dg3sswevldu0oeoizkiwd.ax.internal.cloudapp.net"
  },
  "enableAcceleratedNetworking": false,
  "enableIPForwarding": false,
  "etag": "W/\"063f0e1f-a7f8-4559-8601-4a44b5089c31\"",
  "hostedWorkloads": [],
  "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkInterfaces/avichaiVMNic",
  "ipConfigurations": [
    {
      "etag": "W/\"063f0e1f-a7f8-4559-8601-4a44b5089c31\"",
      "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkInterfaces/avichaiVMNic/ipConfigurations/ipconfigavichai",
      "name": "ipconfigavichai",
      "primary": true,
      "privateIPAddress": "10.0.0.4",
      "privateIPAddressVersion": "IPv4",
      "privateIPAllocationMethod": "Dynamic",
      "provisioningState": "Succeeded",
      "publicIPAddress": {
        "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/publicIPAddresses/avichaiPublicIP",
        "resourceGroup": "test"
      },
      "resourceGroup": "test",
      "subnet": {
        "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/virtualNetworks/avichaiVNET/subnets/avichaiSubnet",
        "resourceGroup": "test"
      },
      "type": "Microsoft.Network/networkInterfaces/ipConfigurations"
    }
  ],
  "location": "westeurope",
  "macAddress": "7C-ED-8D-5C-62-C0",
  "name": "avichaiVMNic",
  "networkSecurityGroup": {
    "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/week8",
    "resourceGroup": "test"
  },
  "nicType": "Standard",
  "primary": true,
  "provisioningState": "Succeeded",
  "resourceGroup": "test",
  "resourceGuid": "d35505a3-4be9-4744-a7e4-cecf7d550721",
  "tags": {},
  "tapConfigurations": [],
  "type": "Microsoft.Network/networkInterfaces",
  "virtualMachine": {
    "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Compute/virtualMachines/avichai",
    "resourceGroup": "test"
  },
  "vnetEncryptionSupported": false
}
Creating Azure File Share...
{
  "accessTier": "Hot",
  "accountMigrationInProgress": null,
  "allowBlobPublicAccess": true,
  "allowCrossTenantReplication": false,
  "allowSharedKeyAccess": null,
  "allowedCopyScope": null,
  "azureFilesIdentityBasedAuthentication": null,
  "blobRestoreStatus": null,
  "creationTime": "2025-06-25T18:31:44.665865+00:00",
  "customDomain": null,
  "defaultToOAuthAuthentication": null,
  "dnsEndpointType": null,
  "enableExtendedGroups": null,
  "enableHttpsTrafficOnly": true,
  "enableNfsV3": null,
  "encryption": {
    "encryptionIdentity": null,
    "keySource": "Microsoft.Storage",
    "keyVaultProperties": null,
    "requireInfrastructureEncryption": null,
    "services": {
      "blob": {
        "enabled": true,
        "keyType": "Account",
        "lastEnabledTime": "2025-06-25T18:31:44.853414+00:00"
      },
      "file": {
        "enabled": true,
        "keyType": "Account",
        "lastEnabledTime": "2025-06-25T18:31:44.853414+00:00"
      },
      "queue": null,
      "table": null
    }
  },
  "extendedLocation": null,
  "failoverInProgress": null,
  "geoReplicationStats": null,
  "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Storage/storageAccounts/teststor2011",
  "identity": null,
  "immutableStorageWithVersioning": null,
  "isHnsEnabled": false,
  "isLocalUserEnabled": null,
  "isSftpEnabled": null,
  "isSkuConversionBlocked": null,
  "keyCreationTime": {
    "key1": "2025-06-25T18:31:44.853414+00:00",
    "key2": "2025-06-25T18:31:44.853414+00:00"
  },
  "keyPolicy": null,
  "kind": "StorageV2",
  "largeFileSharesState": null,
  "lastGeoFailoverTime": null,
  "location": "westeurope",
  "minimumTlsVersion": "TLS1_2",
  "name": "teststor2011",
  "networkRuleSet": {
    "bypass": "AzureServices",
    "defaultAction": "Allow",
    "ipRules": [],
    "ipv6Rules": [],
    "resourceAccessRules": null,
    "virtualNetworkRules": []
  },
  "primaryEndpoints": {
    "blob": "https://teststor2011.blob.core.windows.net/",
    "dfs": "https://teststor2011.dfs.core.windows.net/",
    "file": "https://teststor2011.file.core.windows.net/",
    "internetEndpoints": null,
    "microsoftEndpoints": null,
    "queue": "https://teststor2011.queue.core.windows.net/",
    "table": "https://teststor2011.table.core.windows.net/",
    "web": "https://teststor2011.z6.web.core.windows.net/"
  },
  "primaryLocation": "westeurope",
  "privateEndpointConnections": [],
  "provisioningState": "Succeeded",
  "publicNetworkAccess": null,
  "resourceGroup": "test",
  "routingPreference": null,
  "sasPolicy": null,
  "secondaryEndpoints": null,
  "secondaryLocation": null,
  "sku": {
    "name": "Standard_LRS",
    "tier": "Standard"
  },
  "statusOfPrimary": "available",
  "statusOfSecondary": null,
  "storageAccountSkuConversionStatus": null,
  "tags": {},
  "type": "Microsoft.Storage/storageAccounts"
}
WARNING: 
There are no credentials provided in your command and environment, we will query for account key for your storage account.
It is recommended to provide --connection-string, --account-key or --sas-token in your command as credentials.

In addition, setting the corresponding environment variables can avoid inputting credentials in your command. Please use --help to get more information about environment variable usage.
{
  "created": true
}
Mounting file share on VM...
Pseudo-terminal will not be allocated because stdin is not a terminal.
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 6.8.0-1030-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Wed Jun 25 18:32:11 UTC 2025

  System load:  0.71              Processes:             108
  Usage of /:   8.9% of 28.89GB   Users logged in:       0
  Memory usage: 70%               IPv4 address for eth0: 10.0.0.4
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status

New release '24.04.2 LTS' available.
Run 'do-release-upgrade' to upgrade to it.



WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Hit:1 http://azure.archive.ubuntu.com/ubuntu jammy InRelease
Get:2 http://azure.archive.ubuntu.com/ubuntu jammy-updates InRelease [128 kB]
Get:3 http://azure.archive.ubuntu.com/ubuntu jammy-backports InRelease [127 kB]
Get:4 http://azure.archive.ubuntu.com/ubuntu jammy-security InRelease [129 kB]
Get:5 http://azure.archive.ubuntu.com/ubuntu jammy/universe amd64 Packages [14.1 MB]
Get:6 http://azure.archive.ubuntu.com/ubuntu jammy/universe Translation-en [5652 kB]
Get:7 http://azure.archive.ubuntu.com/ubuntu jammy/universe amd64 c-n-f Metadata [286 kB]
Get:8 http://azure.archive.ubuntu.com/ubuntu jammy/multiverse amd64 Packages [217 kB]
Get:9 http://azure.archive.ubuntu.com/ubuntu jammy/multiverse Translation-en [112 kB]
Get:10 http://azure.archive.ubuntu.com/ubuntu jammy/multiverse amd64 c-n-f Metadata [8372 B]
Get:11 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 Packages [2666 kB]
Get:12 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main Translation-en [429 kB]
Get:13 http://azure.archive.ubuntu.com/ubuntu jammy-updates/restricted amd64 Packages [3720 kB]
Get:14 http://azure.archive.ubuntu.com/ubuntu jammy-updates/restricted Translation-en [668 kB]
Get:15 http://azure.archive.ubuntu.com/ubuntu jammy-updates/universe amd64 Packages [1215 kB]
Get:16 http://azure.archive.ubuntu.com/ubuntu jammy-updates/universe Translation-en [300 kB]
Get:17 http://azure.archive.ubuntu.com/ubuntu jammy-updates/universe amd64 c-n-f Metadata [28.7 kB]
Get:18 http://azure.archive.ubuntu.com/ubuntu jammy-updates/multiverse amd64 Packages [46.5 kB]
Get:19 http://azure.archive.ubuntu.com/ubuntu jammy-updates/multiverse Translation-en [11.8 kB]
Get:20 http://azure.archive.ubuntu.com/ubuntu jammy-updates/multiverse amd64 c-n-f Metadata [592 B]
Get:21 http://azure.archive.ubuntu.com/ubuntu jammy-backports/main amd64 Packages [68.8 kB]
Get:22 http://azure.archive.ubuntu.com/ubuntu jammy-backports/main Translation-en [11.4 kB]
Get:23 http://azure.archive.ubuntu.com/ubuntu jammy-backports/main amd64 c-n-f Metadata [392 B]
Get:24 http://azure.archive.ubuntu.com/ubuntu jammy-backports/restricted amd64 c-n-f Metadata [116 B]
Get:25 http://azure.archive.ubuntu.com/ubuntu jammy-backports/universe amd64 Packages [30.0 kB]
Get:26 http://azure.archive.ubuntu.com/ubuntu jammy-backports/universe Translation-en [16.5 kB]
Get:27 http://azure.archive.ubuntu.com/ubuntu jammy-backports/universe amd64 c-n-f Metadata [672 B]
Get:28 http://azure.archive.ubuntu.com/ubuntu jammy-backports/multiverse amd64 c-n-f Metadata [116 B]
Get:29 http://azure.archive.ubuntu.com/ubuntu jammy-security/main amd64 Packages [2420 kB]
Get:30 http://azure.archive.ubuntu.com/ubuntu jammy-security/main Translation-en [365 kB]
Get:31 http://azure.archive.ubuntu.com/ubuntu jammy-security/restricted amd64 Packages [3595 kB]
Get:32 http://azure.archive.ubuntu.com/ubuntu jammy-security/restricted Translation-en [646 kB]
Get:33 http://azure.archive.ubuntu.com/ubuntu jammy-security/universe amd64 Packages [980 kB]
Get:34 http://azure.archive.ubuntu.com/ubuntu jammy-security/universe Translation-en [212 kB]
Get:35 http://azure.archive.ubuntu.com/ubuntu jammy-security/universe amd64 c-n-f Metadata [21.7 kB]
Get:36 http://azure.archive.ubuntu.com/ubuntu jammy-security/multiverse amd64 Packages [39.6 kB]
Get:37 http://azure.archive.ubuntu.com/ubuntu jammy-security/multiverse Translation-en [8716 B]
Get:38 http://azure.archive.ubuntu.com/ubuntu jammy-security/multiverse amd64 c-n-f Metadata [368 B]
Fetched 38.3 MB in 9s (4364 kB/s)
Reading package lists...
Building dependency tree...
Reading state information...
All packages are up to date.

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Reading package lists...
Building dependency tree...
Reading state information...
cifs-utils is already the newest version (2:6.14-1ubuntu0.3).
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
Transferring application files to the VM...
Connecting to VM and deploying the application...
Pseudo-terminal will not be allocated because stdin is not a terminal.
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 6.8.0-1030-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Wed Jun 25 18:32:11 UTC 2025

  System load:  0.71              Processes:             108
  Usage of /:   8.9% of 28.89GB   Users logged in:       0
  Memory usage: 70%               IPv4 address for eth0: 10.0.0.4
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status

New release '24.04.2 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


Connected to VM.
Installing Docker...

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Hit:1 http://azure.archive.ubuntu.com/ubuntu jammy InRelease
Hit:2 http://azure.archive.ubuntu.com/ubuntu jammy-updates InRelease
Hit:3 http://azure.archive.ubuntu.com/ubuntu jammy-backports InRelease
Hit:4 http://azure.archive.ubuntu.com/ubuntu jammy-security InRelease
Reading package lists...
Building dependency tree...
Reading state information...
All packages are up to date.

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Reading package lists...
Building dependency tree...
Reading state information...
ca-certificates is already the newest version (20240203~22.04.1).
ca-certificates set to manually installed.
curl is already the newest version (7.81.0-1ubuntu1.20).
curl set to manually installed.
gnupg is already the newest version (2.2.27-3ubuntu2.3).
gnupg set to manually installed.
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Hit:1 http://azure.archive.ubuntu.com/ubuntu jammy InRelease
Hit:2 http://azure.archive.ubuntu.com/ubuntu jammy-updates InRelease
Hit:3 http://azure.archive.ubuntu.com/ubuntu jammy-backports InRelease
Hit:4 http://azure.archive.ubuntu.com/ubuntu jammy-security InRelease
Get:5 https://download.docker.com/linux/ubuntu jammy InRelease [48.8 kB]
Get:6 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages [51.9 kB]
Fetched 101 kB in 1s (100 kB/s)
Reading package lists...
Building dependency tree...
Reading state information...
All packages are up to date.

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Reading package lists...
Building dependency tree...
Reading state information...
The following additional packages will be installed:
  docker-ce-rootless-extras libltdl7 libslirp0 pigz slirp4netns
Suggested packages:
  cgroupfs-mount | cgroup-lite docker-model-plugin
The following NEW packages will be installed:
  containerd.io docker-buildx-plugin docker-ce docker-ce-cli
  docker-ce-rootless-extras docker-compose-plugin libltdl7 libslirp0 pigz
  slirp4netns
0 upgraded, 10 newly installed, 0 to remove and 0 not upgraded.
Need to get 103 MB of archives.
After this operation, 429 MB of additional disk space will be used.
Get:1 https://download.docker.com/linux/ubuntu jammy/stable amd64 containerd.io amd64 1.7.27-1 [30.5 MB]
Get:2 https://download.docker.com/linux/ubuntu jammy/stable amd64 docker-ce-cli amd64 5:28.3.0-1~ubuntu.22.04~jammy [16.5 MB]
Get:3 https://download.docker.com/linux/ubuntu jammy/stable amd64 docker-ce amd64 5:28.3.0-1~ubuntu.22.04~jammy [19.7 MB]
Get:4 https://download.docker.com/linux/ubuntu jammy/stable amd64 docker-buildx-plugin amd64 0.25.0-1~ubuntu.22.04~jammy [15.6 MB]
Get:5 http://azure.archive.ubuntu.com/ubuntu jammy/universe amd64 pigz amd64 2.6-1 [63.6 kB]
Get:6 http://azure.archive.ubuntu.com/ubuntu jammy/main amd64 libltdl7 amd64 2.4.6-15build2 [39.6 kB]
Get:7 http://azure.archive.ubuntu.com/ubuntu jammy/main amd64 libslirp0 amd64 4.6.1-1build1 [61.5 kB]
Get:8 http://azure.archive.ubuntu.com/ubuntu jammy/universe amd64 slirp4netns amd64 1.0.1-2 [28.2 kB]
Get:9 https://download.docker.com/linux/ubuntu jammy/stable amd64 docker-ce-rootless-extras amd64 5:28.3.0-1~ubuntu.22.04~jammy [6480 kB]
Get:10 https://download.docker.com/linux/ubuntu jammy/stable amd64 docker-compose-plugin amd64 2.37.3-1~ubuntu.22.04~jammy [14.2 MB]
debconf: unable to initialize frontend: Dialog
debconf: (Dialog frontend will not work on a dumb terminal, an emacs shell buffer, or without a controlling terminal.)
debconf: falling back to frontend: Readline
debconf: unable to initialize frontend: Readline
debconf: (This frontend requires a controlling tty.)
debconf: falling back to frontend: Teletype
dpkg-preconfigure: unable to re-open stdin: 
Fetched 103 MB in 6s (18.1 MB/s)
Selecting previously unselected package containerd.io.
(Reading database ... (Reading database ... 5%(Reading database ... 10%(Reading database ... 15%(Reading database ... 20%(Reading database ... 25%(Reading database ... 30%(Reading database ... 35%(Reading database ... 40%(Reading database ... 45%(Reading database ... 50%(Reading database ... 55%(Reading database ... 60%(Reading database ... 65%(Reading database ... 70%(Reading database ... 75%(Reading database ... 80%(Reading database ... 85%(Reading database ... 90%(Reading database ... 95%(Reading database ... 100%(Reading database ... 62805 files and directories currently installed.)
Preparing to unpack .../0-containerd.io_1.7.27-1_amd64.deb ...
Unpacking containerd.io (1.7.27-1) ...
Selecting previously unselected package docker-ce-cli.
Preparing to unpack .../1-docker-ce-cli_5%3a28.3.0-1~ubuntu.22.04~jammy_amd64.deb ...
Unpacking docker-ce-cli (5:28.3.0-1~ubuntu.22.04~jammy) ...
Selecting previously unselected package docker-ce.
Preparing to unpack .../2-docker-ce_5%3a28.3.0-1~ubuntu.22.04~jammy_amd64.deb ...
Unpacking docker-ce (5:28.3.0-1~ubuntu.22.04~jammy) ...
Selecting previously unselected package pigz.
Preparing to unpack .../3-pigz_2.6-1_amd64.deb ...
Unpacking pigz (2.6-1) ...
Selecting previously unselected package docker-buildx-plugin.
Preparing to unpack .../4-docker-buildx-plugin_0.25.0-1~ubuntu.22.04~jammy_amd64.deb ...
Unpacking docker-buildx-plugin (0.25.0-1~ubuntu.22.04~jammy) ...
Selecting previously unselected package docker-ce-rootless-extras.
Preparing to unpack .../5-docker-ce-rootless-extras_5%3a28.3.0-1~ubuntu.22.04~jammy_amd64.deb ...
Unpacking docker-ce-rootless-extras (5:28.3.0-1~ubuntu.22.04~jammy) ...
Selecting previously unselected package docker-compose-plugin.
Preparing to unpack .../6-docker-compose-plugin_2.37.3-1~ubuntu.22.04~jammy_amd64.deb ...
Unpacking docker-compose-plugin (2.37.3-1~ubuntu.22.04~jammy) ...
Selecting previously unselected package libltdl7:amd64.
Preparing to unpack .../7-libltdl7_2.4.6-15build2_amd64.deb ...
Unpacking libltdl7:amd64 (2.4.6-15build2) ...
Selecting previously unselected package libslirp0:amd64.
Preparing to unpack .../8-libslirp0_4.6.1-1build1_amd64.deb ...
Unpacking libslirp0:amd64 (4.6.1-1build1) ...
Selecting previously unselected package slirp4netns.
Preparing to unpack .../9-slirp4netns_1.0.1-2_amd64.deb ...
Unpacking slirp4netns (1.0.1-2) ...
Setting up docker-buildx-plugin (0.25.0-1~ubuntu.22.04~jammy) ...
Setting up containerd.io (1.7.27-1) ...
Created symlink /etc/systemd/system/multi-user.target.wants/containerd.service → /lib/systemd/system/containerd.service.
Setting up docker-compose-plugin (2.37.3-1~ubuntu.22.04~jammy) ...
Setting up libltdl7:amd64 (2.4.6-15build2) ...
Setting up docker-ce-cli (5:28.3.0-1~ubuntu.22.04~jammy) ...
Setting up libslirp0:amd64 (4.6.1-1build1) ...
Setting up pigz (2.6-1) ...
Setting up docker-ce-rootless-extras (5:28.3.0-1~ubuntu.22.04~jammy) ...
Setting up slirp4netns (1.0.1-2) ...
Setting up docker-ce (5:28.3.0-1~ubuntu.22.04~jammy) ...
Created symlink /etc/systemd/system/multi-user.target.wants/docker.service → /lib/systemd/system/docker.service.
Created symlink /etc/systemd/system/sockets.target.wants/docker.socket → /lib/systemd/system/docker.socket.
Processing triggers for man-db (2.10.2-1) ...
Processing triggers for libc-bin (2.35-0ubuntu3.10) ...

Running kernel seems to be up-to-date.

No services need to be restarted.

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.
Running the application...
time="2025-06-25T18:34:10Z" level=warning msg="/home/avichai98/week8/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion"
 mongo Pulling 
 d9d352c11bbd Pulling fs layer 
 0a4282d2a9c9 Pulling fs layer 
 e88cb4c0b31e Pulling fs layer 
 06b43d55bbbc Pulling fs layer 
 697905244caf Pulling fs layer 
 ebd0c6090698 Pulling fs layer 
 3e961522d85c Pulling fs layer 
 35581a5e0588 Pulling fs layer 
 06b43d55bbbc Waiting 
 697905244caf Waiting 
 ebd0c6090698 Waiting 
 3e961522d85c Waiting 
 35581a5e0588 Waiting 
 e88cb4c0b31e Downloading [>                                                  ]  15.99kB/1.509MB
 0a4282d2a9c9 Downloading [======================================>            ]     933B/1.216kB
 0a4282d2a9c9 Downloading [==================================================>]  1.216kB/1.216kB
 0a4282d2a9c9 Verifying Checksum 
 0a4282d2a9c9 Download complete 
 e88cb4c0b31e Verifying Checksum 
 e88cb4c0b31e Download complete 
 d9d352c11bbd Downloading [>                                                  ]  310.7kB/29.72MB
 d9d352c11bbd Downloading [=>                                                 ]  929.2kB/29.72MB
 06b43d55bbbc Downloading [>                                                  ]  12.32kB/1.131MB
 d9d352c11bbd Downloading [==>                                                ]  1.239MB/29.72MB
 697905244caf Downloading [==================================================>]     116B/116B
 697905244caf Verifying Checksum 
 697905244caf Download complete 
 06b43d55bbbc Downloading [=============>                                     ]  311.3kB/1.131MB
 d9d352c11bbd Downloading [==>                                                ]  1.551MB/29.72MB
 06b43d55bbbc Downloading [=========================>                         ]  571.8kB/1.131MB
 d9d352c11bbd Downloading [===>                                               ]  1.862MB/29.72MB
 06b43d55bbbc Downloading [===================================>               ]  813.5kB/1.131MB
 ebd0c6090698 Downloading [==================================================>]     262B/262B
 ebd0c6090698 Verifying Checksum 
 ebd0c6090698 Download complete 
 d9d352c11bbd Downloading [===>                                               ]  2.173MB/29.72MB
 06b43d55bbbc Downloading [==============================================>    ]  1.055MB/1.131MB
 06b43d55bbbc Downloading [==================================================>]  1.131MB/1.131MB
 06b43d55bbbc Verifying Checksum 
 06b43d55bbbc Download complete 
 d9d352c11bbd Downloading [====>                                              ]  2.485MB/29.72MB
 d9d352c11bbd Downloading [====>                                              ]  2.784MB/29.72MB
 35581a5e0588 Downloading [=========>                                         ]     933B/5kB
 35581a5e0588 Downloading [==================================================>]      5kB/5kB
 35581a5e0588 Verifying Checksum 
 35581a5e0588 Download complete 
 3e961522d85c Downloading [>                                                  ]  527.8kB/259.8MB
 d9d352c11bbd Downloading [======>                                            ]  4.025MB/29.72MB
 3e961522d85c Downloading [>                                                  ]  2.673MB/259.8MB
 d9d352c11bbd Downloading [================>                                  ]  9.886MB/29.72MB
 3e961522d85c Downloading [=>                                                 ]  8.559MB/259.8MB
 d9d352c11bbd Downloading [============================>                      ]  16.66MB/29.72MB
 3e961522d85c Downloading [===>                                               ]  16.08MB/259.8MB
 d9d352c11bbd Downloading [=========================================>         ]  24.63MB/29.72MB
 3e961522d85c Downloading [===>                                               ]  16.62MB/259.8MB
 d9d352c11bbd Verifying Checksum 
 d9d352c11bbd Download complete 
 3e961522d85c Downloading [===>                                               ]  19.84MB/259.8MB
 3e961522d85c Downloading [=====>                                             ]  26.81MB/259.8MB
 3e961522d85c Downloading [=======>                                           ]  38.05MB/259.8MB
 d9d352c11bbd Extracting [>                                                  ]  327.7kB/29.72MB
 3e961522d85c Downloading [=========>                                         ]  51.48MB/259.8MB
 d9d352c11bbd Extracting [=>                                                 ]  655.4kB/29.72MB
 3e961522d85c Downloading [===========>                                       ]  61.14MB/259.8MB
 d9d352c11bbd Extracting [=>                                                 ]    983kB/29.72MB
 3e961522d85c Downloading [=============>                                     ]  70.24MB/259.8MB
 3e961522d85c Downloading [===============>                                   ]  78.82MB/259.8MB
 3e961522d85c Downloading [================>                                  ]  87.42MB/259.8MB
 d9d352c11bbd Extracting [==>                                                ]  1.311MB/29.72MB
 3e961522d85c Downloading [=================>                                 ]  89.57MB/259.8MB
 d9d352c11bbd Extracting [==>                                                ]  1.638MB/29.72MB
 3e961522d85c Downloading [==================>                                ]  96.56MB/259.8MB
 3e961522d85c Downloading [===================>                               ]    103MB/259.8MB
 3e961522d85c Downloading [====================>                              ]  104.6MB/259.8MB
 d9d352c11bbd Extracting [===>                                               ]  1.966MB/29.72MB
 3e961522d85c Downloading [=====================>                             ]  113.7MB/259.8MB
 d9d352c11bbd Extracting [===>                                               ]  2.294MB/29.72MB
 3e961522d85c Downloading [=======================>                           ]  122.3MB/259.8MB
 3e961522d85c Downloading [=========================>                         ]  130.4MB/259.8MB
 3e961522d85c Downloading [==========================>                        ]  138.4MB/259.8MB
 d9d352c11bbd Extracting [====>                                              ]  2.621MB/29.72MB
 3e961522d85c Downloading [============================>                      ]  146.5MB/259.8MB
 d9d352c11bbd Extracting [====>                                              ]  2.949MB/29.72MB
 3e961522d85c Downloading [=============================>                     ]  155.6MB/259.8MB
 3e961522d85c Downloading [================================>                  ]  166.9MB/259.8MB
 d9d352c11bbd Extracting [=====>                                             ]  3.277MB/29.72MB
 3e961522d85c Downloading [=================================>                 ]  172.2MB/259.8MB
 3e961522d85c Downloading [==================================>                ]  180.8MB/259.8MB
 d9d352c11bbd Extracting [======>                                            ]  3.604MB/29.72MB
 3e961522d85c Downloading [====================================>              ]  188.3MB/259.8MB
 3e961522d85c Downloading [=====================================>             ]  197.4MB/259.8MB
 d9d352c11bbd Extracting [======>                                            ]  3.932MB/29.72MB
 3e961522d85c Downloading [======================================>            ]  202.2MB/259.8MB
 3e961522d85c Downloading [=======================================>           ]    206MB/259.8MB
 3e961522d85c Downloading [=========================================>         ]  215.6MB/259.8MB
 d9d352c11bbd Extracting [=======>                                           ]   4.26MB/29.72MB
 3e961522d85c Downloading [===========================================>       ]  225.3MB/259.8MB
 3e961522d85c Downloading [============================================>      ]  230.7MB/259.8MB
 3e961522d85c Downloading [==============================================>    ]  239.2MB/259.8MB
 d9d352c11bbd Extracting [=======>                                           ]  4.588MB/29.72MB
 3e961522d85c Downloading [===============================================>   ]  247.8MB/259.8MB
 d9d352c11bbd Extracting [========>                                          ]  5.243MB/29.72MB
 3e961522d85c Downloading [================================================>  ]  254.3MB/259.8MB
 3e961522d85c Verifying Checksum 
 3e961522d85c Download complete 
 d9d352c11bbd Extracting [=========>                                         ]  5.571MB/29.72MB
 d9d352c11bbd Extracting [=========>                                         ]  5.898MB/29.72MB
 d9d352c11bbd Extracting [============>                                      ]  7.209MB/29.72MB
 d9d352c11bbd Extracting [=============>                                     ]  7.864MB/29.72MB
 d9d352c11bbd Extracting [================>                                  ]   9.83MB/29.72MB
 d9d352c11bbd Extracting [====================>                              ]  12.12MB/29.72MB
 d9d352c11bbd Extracting [=======================>                           ]  14.09MB/29.72MB
 d9d352c11bbd Extracting [============================>                      ]  16.71MB/29.72MB
 d9d352c11bbd Extracting [=================================>                 ]  19.66MB/29.72MB
 d9d352c11bbd Extracting [==================================>                ]  20.32MB/29.72MB
 d9d352c11bbd Extracting [======================================>            ]  22.61MB/29.72MB
 d9d352c11bbd Extracting [=========================================>         ]   24.9MB/29.72MB
 d9d352c11bbd Extracting [===========================================>       ]  25.56MB/29.72MB
 d9d352c11bbd Extracting [==============================================>    ]  27.53MB/29.72MB
 d9d352c11bbd Extracting [=================================================> ]  29.16MB/29.72MB
 d9d352c11bbd Extracting [==================================================>]  29.72MB/29.72MB
 d9d352c11bbd Pull complete 
 0a4282d2a9c9 Extracting [==================================================>]  1.216kB/1.216kB
 0a4282d2a9c9 Extracting [==================================================>]  1.216kB/1.216kB
 0a4282d2a9c9 Pull complete 
 e88cb4c0b31e Extracting [=>                                                 ]  32.77kB/1.509MB
 e88cb4c0b31e Extracting [==========>                                        ]  327.7kB/1.509MB
 e88cb4c0b31e Extracting [=======================================>           ]   1.18MB/1.509MB
 e88cb4c0b31e Extracting [=================================================> ]  1.507MB/1.509MB
 e88cb4c0b31e Extracting [==================================================>]  1.509MB/1.509MB
 e88cb4c0b31e Pull complete 
 06b43d55bbbc Extracting [=>                                                 ]  32.77kB/1.131MB
 06b43d55bbbc Extracting [==========>                                        ]  229.4kB/1.131MB
 06b43d55bbbc Extracting [==================================================>]  1.131MB/1.131MB
 06b43d55bbbc Extracting [==================================================>]  1.131MB/1.131MB
 06b43d55bbbc Pull complete 
 697905244caf Extracting [==================================================>]     116B/116B
 697905244caf Extracting [==================================================>]     116B/116B
 697905244caf Pull complete 
 ebd0c6090698 Extracting [==================================================>]     262B/262B
 ebd0c6090698 Extracting [==================================================>]     262B/262B
 ebd0c6090698 Pull complete 
 3e961522d85c Extracting [>                                                  ]  557.1kB/259.8MB
 3e961522d85c Extracting [>                                                  ]  3.342MB/259.8MB
 3e961522d85c Extracting [=>                                                 ]  8.356MB/259.8MB
 3e961522d85c Extracting [=>                                                 ]  10.03MB/259.8MB
 3e961522d85c Extracting [==>                                                ]  10.58MB/259.8MB
 3e961522d85c Extracting [==>                                                ]  11.14MB/259.8MB
 3e961522d85c Extracting [==>                                                ]  13.37MB/259.8MB
 3e961522d85c Extracting [===>                                               ]  16.71MB/259.8MB
 3e961522d85c Extracting [===>                                               ]  18.94MB/259.8MB
 3e961522d85c Extracting [====>                                              ]  21.73MB/259.8MB
 3e961522d85c Extracting [====>                                              ]  24.51MB/259.8MB
 3e961522d85c Extracting [=====>                                             ]   27.3MB/259.8MB
 3e961522d85c Extracting [=====>                                             ]  30.08MB/259.8MB
 3e961522d85c Extracting [======>                                            ]  33.42MB/259.8MB
 3e961522d85c Extracting [======>                                            ]  35.09MB/259.8MB
 3e961522d85c Extracting [=======>                                           ]  37.32MB/259.8MB
 3e961522d85c Extracting [=======>                                           ]  38.99MB/259.8MB
 3e961522d85c Extracting [========>                                          ]  42.34MB/259.8MB
 3e961522d85c Extracting [========>                                          ]  44.01MB/259.8MB
 3e961522d85c Extracting [=========>                                         ]  46.79MB/259.8MB
 3e961522d85c Extracting [=========>                                         ]  49.58MB/259.8MB
 3e961522d85c Extracting [=========>                                         ]  51.25MB/259.8MB
 3e961522d85c Extracting [==========>                                        ]  53.48MB/259.8MB
 3e961522d85c Extracting [==========>                                        ]  56.26MB/259.8MB
 3e961522d85c Extracting [===========>                                       ]  57.38MB/259.8MB
 3e961522d85c Extracting [===========>                                       ]   59.6MB/259.8MB
 3e961522d85c Extracting [===========>                                       ]  60.72MB/259.8MB
 3e961522d85c Extracting [============>                                      ]  62.39MB/259.8MB
 3e961522d85c Extracting [============>                                      ]  62.95MB/259.8MB
 3e961522d85c Extracting [============>                                      ]   63.5MB/259.8MB
 3e961522d85c Extracting [============>                                      ]  64.62MB/259.8MB
 3e961522d85c Extracting [============>                                      ]  65.73MB/259.8MB
 3e961522d85c Extracting [============>                                      ]   67.4MB/259.8MB
 3e961522d85c Extracting [=============>                                     ]  67.96MB/259.8MB
 3e961522d85c Extracting [=============>                                     ]  70.75MB/259.8MB
 3e961522d85c Extracting [==============>                                    ]  76.32MB/259.8MB
 3e961522d85c Extracting [===============>                                   ]  78.54MB/259.8MB
 3e961522d85c Extracting [================>                                  ]  83.56MB/259.8MB
 3e961522d85c Extracting [================>                                  ]  85.79MB/259.8MB
 3e961522d85c Extracting [================>                                  ]  86.34MB/259.8MB
 3e961522d85c Extracting [=================>                                 ]  89.13MB/259.8MB
 3e961522d85c Extracting [==================>                                ]  93.59MB/259.8MB
 3e961522d85c Extracting [==================>                                ]  96.37MB/259.8MB
 3e961522d85c Extracting [===================>                               ]  99.16MB/259.8MB
 3e961522d85c Extracting [===================>                               ]  103.1MB/259.8MB
 3e961522d85c Extracting [====================>                              ]  104.2MB/259.8MB
 3e961522d85c Extracting [====================>                              ]  106.4MB/259.8MB
 3e961522d85c Extracting [=====================>                             ]  111.4MB/259.8MB
 3e961522d85c Extracting [=====================>                             ]  114.2MB/259.8MB
 3e961522d85c Extracting [======================>                            ]  114.8MB/259.8MB
 3e961522d85c Extracting [======================>                            ]  115.3MB/259.8MB
 3e961522d85c Extracting [======================>                            ]  116.4MB/259.8MB
 3e961522d85c Extracting [======================>                            ]  118.7MB/259.8MB
 3e961522d85c Extracting [=======================>                           ]  123.7MB/259.8MB
 3e961522d85c Extracting [=======================>                           ]  124.2MB/259.8MB
 3e961522d85c Extracting [========================>                          ]    127MB/259.8MB
 3e961522d85c Extracting [========================>                          ]  129.8MB/259.8MB
 3e961522d85c Extracting [=========================>                         ]  131.5MB/259.8MB
 3e961522d85c Extracting [=========================>                         ]  133.7MB/259.8MB
 3e961522d85c Extracting [=========================>                         ]  134.8MB/259.8MB
 3e961522d85c Extracting [==========================>                        ]  137.6MB/259.8MB
 3e961522d85c Extracting [==========================>                        ]  138.7MB/259.8MB
 3e961522d85c Extracting [===========================>                       ]  141.5MB/259.8MB
 3e961522d85c Extracting [===========================>                       ]  142.6MB/259.8MB
 3e961522d85c Extracting [===========================>                       ]  145.4MB/259.8MB
 3e961522d85c Extracting [============================>                      ]  146.5MB/259.8MB
 3e961522d85c Extracting [============================>                      ]  149.8MB/259.8MB
 3e961522d85c Extracting [=============================>                     ]  152.1MB/259.8MB
 3e961522d85c Extracting [=============================>                     ]  153.2MB/259.8MB
 3e961522d85c Extracting [=============================>                     ]  154.3MB/259.8MB
 3e961522d85c Extracting [=============================>                     ]  154.9MB/259.8MB
 3e961522d85c Extracting [=============================>                     ]  155.4MB/259.8MB
 3e961522d85c Extracting [==============================>                    ]  157.6MB/259.8MB
 3e961522d85c Extracting [==============================>                    ]  160.4MB/259.8MB
 3e961522d85c Extracting [===============================>                   ]  163.2MB/259.8MB
 3e961522d85c Extracting [===============================>                   ]  164.3MB/259.8MB
 3e961522d85c Extracting [================================>                  ]  167.1MB/259.8MB
 3e961522d85c Extracting [================================>                  ]  170.5MB/259.8MB
 3e961522d85c Extracting [=================================>                 ]  171.6MB/259.8MB
 3e961522d85c Extracting [=================================>                 ]  172.7MB/259.8MB
 3e961522d85c Extracting [=================================>                 ]  174.9MB/259.8MB
 3e961522d85c Extracting [=================================>                 ]  175.5MB/259.8MB
 3e961522d85c Extracting [==================================>                ]  178.3MB/259.8MB
 3e961522d85c Extracting [==================================>                ]  180.5MB/259.8MB
 3e961522d85c Extracting [===================================>               ]  182.7MB/259.8MB
 3e961522d85c Extracting [===================================>               ]  185.5MB/259.8MB
 3e961522d85c Extracting [===================================>               ]  186.6MB/259.8MB
 3e961522d85c Extracting [====================================>              ]  189.4MB/259.8MB
 3e961522d85c Extracting [====================================>              ]  190.5MB/259.8MB
 3e961522d85c Extracting [=====================================>             ]  193.3MB/259.8MB
 3e961522d85c Extracting [=====================================>             ]  193.9MB/259.8MB
 3e961522d85c Extracting [=====================================>             ]  196.1MB/259.8MB
 3e961522d85c Extracting [======================================>            ]  200.5MB/259.8MB
 3e961522d85c Extracting [======================================>            ]  201.7MB/259.8MB
 3e961522d85c Extracting [=======================================>           ]  202.8MB/259.8MB
 3e961522d85c Extracting [=======================================>           ]    205MB/259.8MB
 3e961522d85c Extracting [=======================================>           ]  205.6MB/259.8MB
 3e961522d85c Extracting [=======================================>           ]  207.8MB/259.8MB
 3e961522d85c Extracting [========================================>          ]  209.5MB/259.8MB
 3e961522d85c Extracting [=========================================>         ]  214.5MB/259.8MB
 3e961522d85c Extracting [=========================================>         ]  216.7MB/259.8MB
 3e961522d85c Extracting [==========================================>        ]  221.7MB/259.8MB
 3e961522d85c Extracting [==========================================>        ]  222.3MB/259.8MB
 3e961522d85c Extracting [===========================================>       ]  223.9MB/259.8MB
 3e961522d85c Extracting [============================================>      ]    229MB/259.8MB
 3e961522d85c Extracting [============================================>      ]  229.5MB/259.8MB
 3e961522d85c Extracting [============================================>      ]  232.3MB/259.8MB
 3e961522d85c Extracting [=============================================>     ]    234MB/259.8MB
 3e961522d85c Extracting [=============================================>     ]  236.7MB/259.8MB
 3e961522d85c Extracting [=============================================>     ]  237.3MB/259.8MB
 3e961522d85c Extracting [==============================================>    ]  240.1MB/259.8MB
 3e961522d85c Extracting [==============================================>    ]  243.4MB/259.8MB
 3e961522d85c Extracting [===============================================>   ]  246.2MB/259.8MB
 3e961522d85c Extracting [===============================================>   ]  247.3MB/259.8MB
 3e961522d85c Extracting [================================================>  ]  250.1MB/259.8MB
 3e961522d85c Extracting [================================================>  ]  251.2MB/259.8MB
 3e961522d85c Extracting [================================================>  ]  253.5MB/259.8MB
 3e961522d85c Extracting [================================================>  ]    254MB/259.8MB
 3e961522d85c Extracting [=================================================> ]  255.1MB/259.8MB
 3e961522d85c Extracting [=================================================> ]  255.7MB/259.8MB
 3e961522d85c Extracting [=================================================> ]  256.2MB/259.8MB
 3e961522d85c Extracting [=================================================> ]  256.8MB/259.8MB
 3e961522d85c Extracting [=================================================> ]    259MB/259.8MB
 3e961522d85c Extracting [=================================================> ]  259.6MB/259.8MB
 3e961522d85c Extracting [==================================================>]  259.8MB/259.8MB
 3e961522d85c Pull complete 
 35581a5e0588 Extracting [==================================================>]      5kB/5kB
 35581a5e0588 Extracting [==================================================>]      5kB/5kB
 35581a5e0588 Pull complete 
 mongo Pulled 
#1 [internal] load local bake definitions
#1 reading from stdin 642B done
#1 DONE 0.0s

#2 [frontend internal] load build definition from Dockerfile
#2 ...

#3 [backend internal] load build definition from Dockerfile
#3 transferring dockerfile: 669B 0.0s done
#3 DONE 0.4s

#2 [frontend internal] load build definition from Dockerfile
#2 transferring dockerfile: 181B 0.0s done
#2 DONE 0.4s

#4 [frontend internal] load metadata for docker.io/library/node:20-alpine
#4 DONE 1.8s

#5 [backend internal] load metadata for docker.io/library/python:3.11-slim
#5 DONE 1.9s

#6 [backend internal] load .dockerignore
#6 ...

#7 [frontend internal] load .dockerignore
#7 transferring context: 2B done
#7 DONE 0.2s

#6 [backend internal] load .dockerignore
#6 transferring context: 100B 0.0s done
#6 DONE 0.2s

#8 [frontend 1/5] FROM docker.io/library/node:20-alpine@sha256:674181320f4f94582c6182eaa151bf92c6744d478be0f1d12db804b7d59b2d11
#8 resolve docker.io/library/node:20-alpine@sha256:674181320f4f94582c6182eaa151bf92c6744d478be0f1d12db804b7d59b2d11
#8 ...

#9 [backend internal] load build context
#9 DONE 0.0s

#10 [frontend internal] load build context
#10 transferring context: 110.08kB 0.2s done
#10 DONE 0.4s

#8 [frontend 1/5] FROM docker.io/library/node:20-alpine@sha256:674181320f4f94582c6182eaa151bf92c6744d478be0f1d12db804b7d59b2d11
#8 resolve docker.io/library/node:20-alpine@sha256:674181320f4f94582c6182eaa151bf92c6744d478be0f1d12db804b7d59b2d11 0.4s done
#8 sha256:674181320f4f94582c6182eaa151bf92c6744d478be0f1d12db804b7d59b2d11 7.67kB / 7.67kB done
#8 sha256:6d6b06f970b08f9ebbe65a5561c20e8623d6afa612ea035bbbe38fb78dd94b14 1.72kB / 1.72kB done
#8 sha256:bfd94ebedbdada46a3d3447f6bc2de4d271021b3a45a76821cca6afa361ea94d 6.21kB / 6.21kB done
#8 sha256:fe07684b16b82247c3539ed86a65ff37a76138ec25d380bd80c869a1a4c73236 0B / 3.80MB 0.1s
#8 ...

#9 [backend internal] load build context
#9 transferring context: 1.20kB done
#9 DONE 0.2s

#8 [frontend 1/5] FROM docker.io/library/node:20-alpine@sha256:674181320f4f94582c6182eaa151bf92c6744d478be0f1d12db804b7d59b2d11
#8 sha256:5432aa916e0868c8c9385ef60226d5ef530f13fe7c28fc13c054de1df6d006cd 0B / 42.99MB 0.3s
#8 sha256:2506673f55362e86b6c8a2ab9c01541ae636887386c92d06e01286d3ddd83871 0B / 1.26MB 0.3s
#8 sha256:fe07684b16b82247c3539ed86a65ff37a76138ec25d380bd80c869a1a4c73236 1.05MB / 3.80MB 0.6s
#8 sha256:fe07684b16b82247c3539ed86a65ff37a76138ec25d380bd80c869a1a4c73236 3.80MB / 3.80MB 0.9s
#8 sha256:5432aa916e0868c8c9385ef60226d5ef530f13fe7c28fc13c054de1df6d006cd 6.29MB / 42.99MB 0.9s
#8 sha256:2506673f55362e86b6c8a2ab9c01541ae636887386c92d06e01286d3ddd83871 1.26MB / 1.26MB 0.9s
#8 sha256:5432aa916e0868c8c9385ef60226d5ef530f13fe7c28fc13c054de1df6d006cd 13.63MB / 42.99MB 1.0s
#8 sha256:5432aa916e0868c8c9385ef60226d5ef530f13fe7c28fc13c054de1df6d006cd 24.12MB / 42.99MB 1.1s
#8 sha256:5432aa916e0868c8c9385ef60226d5ef530f13fe7c28fc13c054de1df6d006cd 36.70MB / 42.99MB 1.2s
#8 sha256:5432aa916e0868c8c9385ef60226d5ef530f13fe7c28fc13c054de1df6d006cd 39.85MB / 42.99MB 1.4s
#8 sha256:2506673f55362e86b6c8a2ab9c01541ae636887386c92d06e01286d3ddd83871 1.26MB / 1.26MB 1.0s done
#8 sha256:5432aa916e0868c8c9385ef60226d5ef530f13fe7c28fc13c054de1df6d006cd 42.99MB / 42.99MB 2.4s
#8 sha256:fe07684b16b82247c3539ed86a65ff37a76138ec25d380bd80c869a1a4c73236 3.80MB / 3.80MB 2.5s done
#8 sha256:98c4889b578e94078411d6c14fe8f5daa0303d43e82bbf84d5787ab657c42428 0B / 445B 2.5s
#8 extracting sha256:fe07684b16b82247c3539ed86a65ff37a76138ec25d380bd80c869a1a4c73236
#8 sha256:5432aa916e0868c8c9385ef60226d5ef530f13fe7c28fc13c054de1df6d006cd 42.99MB / 42.99MB 2.5s done
#8 sha256:98c4889b578e94078411d6c14fe8f5daa0303d43e82bbf84d5787ab657c42428 445B / 445B 2.6s done
#8 extracting sha256:fe07684b16b82247c3539ed86a65ff37a76138ec25d380bd80c869a1a4c73236 1.7s done
#8 extracting sha256:5432aa916e0868c8c9385ef60226d5ef530f13fe7c28fc13c054de1df6d006cd
#8 ...

#11 [backend 1/5] FROM docker.io/library/python:3.11-slim@sha256:9e1912aab0a30bbd9488eb79063f68f42a68ab0946cbe98fecf197fe5b085506
#11 resolve docker.io/library/python:3.11-slim@sha256:9e1912aab0a30bbd9488eb79063f68f42a68ab0946cbe98fecf197fe5b085506 0.3s done
#11 sha256:cfa2a40862158178855ab4f7cf6b9341646f826b0467a7b72bdeac68b03986bb 1.75kB / 1.75kB done
#11 sha256:be3324b8ee1a17161c5fa4a20f310d4af42cbb4f22a1e7a32a98ee9196a6defd 5.37kB / 5.37kB done
#11 sha256:9e1912aab0a30bbd9488eb79063f68f42a68ab0946cbe98fecf197fe5b085506 9.13kB / 9.13kB done
#11 sha256:dad67da3f26bce15939543965e09c4059533b025f707aad72ed3d3f3a09c66f8 28.23MB / 28.23MB 3.3s done
#11 sha256:799440a7bae7c08a5fe9d9e5a1ccd72fc3cbf9d85fa4be450e12b8550175c620 3.51MB / 3.51MB 4.0s done
#11 sha256:9596beeb5a6dc0950529870568799000e8d73fb678969ac2f485005cd5da1087 16.21MB / 16.21MB 4.0s done
#11 sha256:15658014cd85cd0d8b913d50b4388228aebcf0437d43cfb37e8a5177e8b2bcf8 248B / 248B 4.0s done
#11 extracting sha256:dad67da3f26bce15939543965e09c4059533b025f707aad72ed3d3f3a09c66f8 3.8s done
#11 extracting sha256:799440a7bae7c08a5fe9d9e5a1ccd72fc3cbf9d85fa4be450e12b8550175c620 1.0s done
#11 extracting sha256:9596beeb5a6dc0950529870568799000e8d73fb678969ac2f485005cd5da1087
#11 ...

#8 [frontend 1/5] FROM docker.io/library/node:20-alpine@sha256:674181320f4f94582c6182eaa151bf92c6744d478be0f1d12db804b7d59b2d11
#8 extracting sha256:5432aa916e0868c8c9385ef60226d5ef530f13fe7c28fc13c054de1df6d006cd 5.1s
#8 extracting sha256:5432aa916e0868c8c9385ef60226d5ef530f13fe7c28fc13c054de1df6d006cd 6.5s done
#8 extracting sha256:2506673f55362e86b6c8a2ab9c01541ae636887386c92d06e01286d3ddd83871
#8 extracting sha256:2506673f55362e86b6c8a2ab9c01541ae636887386c92d06e01286d3ddd83871 0.3s done
#8 extracting sha256:98c4889b578e94078411d6c14fe8f5daa0303d43e82bbf84d5787ab657c42428 done
#8 DONE 14.2s

#11 [backend 1/5] FROM docker.io/library/python:3.11-slim@sha256:9e1912aab0a30bbd9488eb79063f68f42a68ab0946cbe98fecf197fe5b085506
#11 extracting sha256:9596beeb5a6dc0950529870568799000e8d73fb678969ac2f485005cd5da1087 3.9s done
#11 extracting sha256:15658014cd85cd0d8b913d50b4388228aebcf0437d43cfb37e8a5177e8b2bcf8 done
#11 ...

#12 [frontend 2/5] WORKDIR /app
#12 DONE 0.5s

#13 [frontend 3/5] COPY package.json package-lock.json* ./
#13 ...

#11 [backend 1/5] FROM docker.io/library/python:3.11-slim@sha256:9e1912aab0a30bbd9488eb79063f68f42a68ab0946cbe98fecf197fe5b085506
#11 DONE 15.0s

#13 [frontend 3/5] COPY package.json package-lock.json* ./
#13 DONE 0.5s

#14 [backend 2/5] WORKDIR /app
#14 DONE 0.3s

#15 [frontend 4/5] RUN npm install
#15 ...

#16 [backend 3/5] COPY app.py .
#16 DONE 1.0s

#17 [backend 4/5] COPY requirements.txt .
#17 DONE 0.8s

#15 [frontend 4/5] RUN npm install
#15 ...

#18 [backend 5/5] RUN pip install --no-cache-dir -r requirements.txt
#18 24.60 Collecting Flask==3.1.1 (from -r requirements.txt (line 1))
#18 24.80   Downloading flask-3.1.1-py3-none-any.whl.metadata (3.0 kB)
#18 25.17 Collecting flask-cors==6.0.1 (from -r requirements.txt (line 2))
#18 25.17   Downloading flask_cors-6.0.1-py3-none-any.whl.metadata (5.3 kB)
#18 27.14 Collecting pymongo==4.13.2 (from -r requirements.txt (line 3))
#18 27.35   Downloading pymongo-4.13.2-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (22 kB)
#18 28.20 Collecting blinker>=1.9.0 (from Flask==3.1.1->-r requirements.txt (line 1))
#18 28.29   Downloading blinker-1.9.0-py3-none-any.whl.metadata (1.6 kB)
#18 28.46 Collecting click>=8.1.3 (from Flask==3.1.1->-r requirements.txt (line 1))
#18 28.46   Downloading click-8.2.1-py3-none-any.whl.metadata (2.5 kB)
#18 28.56 Collecting itsdangerous>=2.2.0 (from Flask==3.1.1->-r requirements.txt (line 1))
#18 28.59   Downloading itsdangerous-2.2.0-py3-none-any.whl.metadata (1.9 kB)
#18 28.62 Collecting jinja2>=3.1.2 (from Flask==3.1.1->-r requirements.txt (line 1))
#18 28.63   Downloading jinja2-3.1.6-py3-none-any.whl.metadata (2.9 kB)
#18 35.14 Collecting markupsafe>=2.1.1 (from Flask==3.1.1->-r requirements.txt (line 1))
#18 35.39   Downloading MarkupSafe-3.0.2-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (4.0 kB)
#18 35.51 Collecting werkzeug>=3.1.0 (from Flask==3.1.1->-r requirements.txt (line 1))
#18 35.52   Downloading werkzeug-3.1.3-py3-none-any.whl.metadata (3.7 kB)
#18 35.66 Collecting dnspython<3.0.0,>=1.16.0 (from pymongo==4.13.2->-r requirements.txt (line 3))
#18 35.66   Downloading dnspython-2.7.0-py3-none-any.whl.metadata (5.8 kB)
#18 35.76 Downloading flask-3.1.1-py3-none-any.whl (103 kB)
#18 35.86    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 103.3/103.3 kB 84.9 MB/s eta 0:00:00
#18 35.87 Downloading flask_cors-6.0.1-py3-none-any.whl (13 kB)
#18 35.87 Downloading pymongo-4.13.2-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (1.4 MB)
#18 37.10    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.4/1.4 MB 177.6 MB/s eta 0:00:00
#18 37.14 Downloading blinker-1.9.0-py3-none-any.whl (8.5 kB)
#18 37.14 Downloading click-8.2.1-py3-none-any.whl (102 kB)
#18 37.15    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 102.2/102.2 kB 16.6 MB/s eta 0:00:00
#18 37.16 Downloading dnspython-2.7.0-py3-none-any.whl (313 kB)
#18 37.26    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 313.6/313.6 kB 4.3 MB/s eta 0:00:00
#18 37.29 Downloading itsdangerous-2.2.0-py3-none-any.whl (16 kB)
#18 37.29 Downloading jinja2-3.1.6-py3-none-any.whl (134 kB)
#18 37.33    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 134.9/134.9 kB 3.6 MB/s eta 0:00:00
#18 37.36 Downloading MarkupSafe-3.0.2-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (23 kB)
#18 37.37 Downloading werkzeug-3.1.3-py3-none-any.whl (224 kB)
#18 37.45    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 224.5/224.5 kB 4.8 MB/s eta 0:00:00
#18 37.89 Installing collected packages: markupsafe, itsdangerous, dnspython, click, blinker, werkzeug, pymongo, jinja2, Flask, flask-cors
#18 45.60 Successfully installed Flask-3.1.1 blinker-1.9.0 click-8.2.1 dnspython-2.7.0 flask-cors-6.0.1 itsdangerous-2.2.0 jinja2-3.1.6 markupsafe-3.0.2 pymongo-4.13.2 werkzeug-3.1.3
#18 45.79 WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
#18 70.49 
#18 70.49 [notice] A new release of pip is available: 24.0 -> 25.1.1
#18 70.49 [notice] To update, run: pip install --upgrade pip
#18 ...

#15 [frontend 4/5] RUN npm install
#15 86.53 
#15 86.53 added 155 packages, and audited 156 packages in 1m
#15 86.53 
#15 86.53 33 packages are looking for funding
#15 86.53   run `npm fund` for details
#15 86.72 
#15 86.72 found 0 vulnerabilities
#15 86.79 npm notice
#15 86.79 npm notice New major version of npm available! 10.8.2 -> 11.4.2
#15 86.79 npm notice Changelog: https://github.com/npm/cli/releases/tag/v11.4.2
#15 86.79 npm notice To update run: npm install -g npm@11.4.2
#15 86.79 npm notice
#15 DONE 89.0s

#18 [backend 5/5] RUN pip install --no-cache-dir -r requirements.txt
#18 ...

#19 [frontend 5/5] COPY . .
#19 DONE 3.3s

#18 [backend 5/5] RUN pip install --no-cache-dir -r requirements.txt
#18 ...

#20 [frontend] exporting to image
#20 exporting layers
#20 ...

#18 [backend 5/5] RUN pip install --no-cache-dir -r requirements.txt
#18 DONE 98.4s

#20 [frontend] exporting to image
#20 ...

#21 [backend] exporting to image
#21 exporting layers
#21 exporting layers 18.8s done
#21 writing image sha256:c9579dfed729e0b4663f3c8a67a629b14c179ad72a3c2e6d011e9b8ef05eccb4 0.3s done
#21 naming to docker.io/library/week8-backend 0.1s done
#21 DONE 19.6s

#20 [frontend] exporting to image
#20 ...

#22 [backend] resolving provenance for metadata file
#22 DONE 0.3s

#20 [frontend] exporting to image
#20 exporting layers 31.8s done
#20 writing image sha256:8106995a1845f7f17951aa683186a878fb4c4084cf683761c460c4cf4b67cdcf
#20 writing image sha256:8106995a1845f7f17951aa683186a878fb4c4084cf683761c460c4cf4b67cdcf 0.0s done
#20 naming to docker.io/library/week8-frontend 0.0s done
#20 DONE 31.9s

#23 [frontend] resolving provenance for metadata file
#23 DONE 0.2s
 backend  Built
 frontend  Built
 Network week8_mynet  Creating
 Network week8_mynet  Created
 Volume "week8_mongodb_data"  Creating
 Volume "week8_mongodb_data"  Created
 Container my_mongo  Creating
 Container my_mongo  Created
 Container my_backend  Creating
 Container my_backend  Created
 Container my_frontend  Creating
 Container my_frontend  Created
 Container my_mongo  Starting
 Container my_mongo  Started
 Container my_backend  Starting
 Container my_backend  Started
 Container my_frontend  Starting
 Container my_frontend  Started
Application is running. You can access it at http://4.180.91.175:3000
Installing and configuring NGINX as reverse proxy...
Pseudo-terminal will not be allocated because stdin is not a terminal.
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 6.8.0-1030-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Wed Jun 25 18:32:11 UTC 2025

  System load:  0.71              Processes:             108
  Usage of /:   8.9% of 28.89GB   Users logged in:       0
  Memory usage: 70%               IPv4 address for eth0: 10.0.0.4
  Swap usage:   0%

 * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
   just raised the bar for easy, resilient and secure K8s cluster deployment.

   https://ubuntu.com/engage/secure-kubernetes-at-the-edge

Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status

New release '24.04.2 LTS' available.
Run 'do-release-upgrade' to upgrade to it.



WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Hit:1 http://azure.archive.ubuntu.com/ubuntu jammy InRelease
Hit:2 http://azure.archive.ubuntu.com/ubuntu jammy-updates InRelease
Hit:3 http://azure.archive.ubuntu.com/ubuntu jammy-backports InRelease
Hit:4 http://azure.archive.ubuntu.com/ubuntu jammy-security InRelease
Hit:5 https://download.docker.com/linux/ubuntu jammy InRelease
Reading package lists...
Building dependency tree...
Reading state information...
All packages are up to date.

Reading package lists...WARNING: apt does not have a stable CLI interface. Use with caution in scripts.


Building dependency tree...
Reading state information...
The following additional packages will be installed:
  fontconfig-config fonts-dejavu-core libdeflate0 libfontconfig1 libgd3
  libjbig0 libjpeg-turbo8 libjpeg8 libnginx-mod-http-geoip2
  libnginx-mod-http-image-filter libnginx-mod-http-xslt-filter
  libnginx-mod-mail libnginx-mod-stream libnginx-mod-stream-geoip2 libtiff5
  libwebp7 libxpm4 nginx-common nginx-core
Suggested packages:
  libgd-tools fcgiwrap nginx-doc ssl-cert
The following NEW packages will be installed:
  fontconfig-config fonts-dejavu-core libdeflate0 libfontconfig1 libgd3
  libjbig0 libjpeg-turbo8 libjpeg8 libnginx-mod-http-geoip2
  libnginx-mod-http-image-filter libnginx-mod-http-xslt-filter
  libnginx-mod-mail libnginx-mod-stream libnginx-mod-stream-geoip2 libtiff5
  libwebp7 libxpm4 nginx nginx-common nginx-core
0 upgraded, 20 newly installed, 0 to remove and 0 not upgraded.
Need to get 2693 kB of archives.
After this operation, 8346 kB of additional disk space will be used.
Get:1 http://azure.archive.ubuntu.com/ubuntu jammy/main amd64 fonts-dejavu-core all 2.37-2build1 [1041 kB]
Get:2 http://azure.archive.ubuntu.com/ubuntu jammy/main amd64 fontconfig-config all 2.13.1-4.2ubuntu5 [29.1 kB]
Get:3 http://azure.archive.ubuntu.com/ubuntu jammy/main amd64 libdeflate0 amd64 1.10-2 [70.9 kB]
Get:4 http://azure.archive.ubuntu.com/ubuntu jammy/main amd64 libfontconfig1 amd64 2.13.1-4.2ubuntu5 [131 kB]
Get:5 http://azure.archive.ubuntu.com/ubuntu jammy/main amd64 libjpeg-turbo8 amd64 2.1.2-0ubuntu1 [134 kB]
Get:6 http://azure.archive.ubuntu.com/ubuntu jammy/main amd64 libjpeg8 amd64 8c-2ubuntu10 [2264 B]
Get:7 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libjbig0 amd64 2.1-3.1ubuntu0.22.04.1 [29.2 kB]
Get:8 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libwebp7 amd64 1.2.2-2ubuntu0.22.04.2 [206 kB]
Get:9 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libtiff5 amd64 4.3.0-6ubuntu0.10 [185 kB]
Get:10 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libxpm4 amd64 1:3.5.12-1ubuntu0.22.04.2 [36.7 kB]
Get:11 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libgd3 amd64 2.3.0-2ubuntu2.3 [129 kB]
Get:12 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 nginx-common all 1.18.0-6ubuntu14.6 [40.1 kB]
Get:13 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libnginx-mod-http-geoip2 amd64 1.18.0-6ubuntu14.6 [12.0 kB]
Get:14 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libnginx-mod-http-image-filter amd64 1.18.0-6ubuntu14.6 [15.5 kB]
Get:15 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libnginx-mod-http-xslt-filter amd64 1.18.0-6ubuntu14.6 [13.8 kB]
Get:16 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libnginx-mod-mail amd64 1.18.0-6ubuntu14.6 [45.8 kB]
Get:17 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libnginx-mod-stream amd64 1.18.0-6ubuntu14.6 [73.0 kB]
Get:18 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libnginx-mod-stream-geoip2 amd64 1.18.0-6ubuntu14.6 [10.1 kB]
Get:19 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 nginx-core amd64 1.18.0-6ubuntu14.6 [483 kB]
Get:20 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 nginx amd64 1.18.0-6ubuntu14.6 [3882 B]
debconf: unable to initialize frontend: Dialog
debconf: (Dialog frontend will not work on a dumb terminal, an emacs shell buffer, or without a controlling terminal.)
debconf: falling back to frontend: Readline
debconf: unable to initialize frontend: Readline
debconf: (This frontend requires a controlling tty.)
debconf: falling back to frontend: Teletype
dpkg-preconfigure: unable to re-open stdin: 
Fetched 2693 kB in 1s (3278 kB/s)
Selecting previously unselected package fonts-dejavu-core.
(Reading database ... (Reading database ... 5%(Reading database ... 10%(Reading database ... 15%(Reading database ... 20%(Reading database ... 25%(Reading database ... 30%(Reading database ... 35%(Reading database ... 40%(Reading database ... 45%(Reading database ... 50%(Reading database ... 55%(Reading database ... 60%(Reading database ... 65%(Reading database ... 70%(Reading database ... 75%(Reading database ... 80%(Reading database ... 85%(Reading database ... 90%(Reading database ... 95%(Reading database ... 100%(Reading database ... 63072 files and directories currently installed.)
Preparing to unpack .../00-fonts-dejavu-core_2.37-2build1_all.deb ...
Unpacking fonts-dejavu-core (2.37-2build1) ...
Selecting previously unselected package fontconfig-config.
Preparing to unpack .../01-fontconfig-config_2.13.1-4.2ubuntu5_all.deb ...
Unpacking fontconfig-config (2.13.1-4.2ubuntu5) ...
Selecting previously unselected package libdeflate0:amd64.
Preparing to unpack .../02-libdeflate0_1.10-2_amd64.deb ...
Unpacking libdeflate0:amd64 (1.10-2) ...
Selecting previously unselected package libfontconfig1:amd64.
Preparing to unpack .../03-libfontconfig1_2.13.1-4.2ubuntu5_amd64.deb ...
Unpacking libfontconfig1:amd64 (2.13.1-4.2ubuntu5) ...
Selecting previously unselected package libjpeg-turbo8:amd64.
Preparing to unpack .../04-libjpeg-turbo8_2.1.2-0ubuntu1_amd64.deb ...
Unpacking libjpeg-turbo8:amd64 (2.1.2-0ubuntu1) ...
Selecting previously unselected package libjpeg8:amd64.
Preparing to unpack .../05-libjpeg8_8c-2ubuntu10_amd64.deb ...
Unpacking libjpeg8:amd64 (8c-2ubuntu10) ...
Selecting previously unselected package libjbig0:amd64.
Preparing to unpack .../06-libjbig0_2.1-3.1ubuntu0.22.04.1_amd64.deb ...
Unpacking libjbig0:amd64 (2.1-3.1ubuntu0.22.04.1) ...
Selecting previously unselected package libwebp7:amd64.
Preparing to unpack .../07-libwebp7_1.2.2-2ubuntu0.22.04.2_amd64.deb ...
Unpacking libwebp7:amd64 (1.2.2-2ubuntu0.22.04.2) ...
Selecting previously unselected package libtiff5:amd64.
Preparing to unpack .../08-libtiff5_4.3.0-6ubuntu0.10_amd64.deb ...
Unpacking libtiff5:amd64 (4.3.0-6ubuntu0.10) ...
Selecting previously unselected package libxpm4:amd64.
Preparing to unpack .../09-libxpm4_1%3a3.5.12-1ubuntu0.22.04.2_amd64.deb ...
Unpacking libxpm4:amd64 (1:3.5.12-1ubuntu0.22.04.2) ...
Selecting previously unselected package libgd3:amd64.
Preparing to unpack .../10-libgd3_2.3.0-2ubuntu2.3_amd64.deb ...
Unpacking libgd3:amd64 (2.3.0-2ubuntu2.3) ...
Selecting previously unselected package nginx-common.
Preparing to unpack .../11-nginx-common_1.18.0-6ubuntu14.6_all.deb ...
Unpacking nginx-common (1.18.0-6ubuntu14.6) ...
Selecting previously unselected package libnginx-mod-http-geoip2.
Preparing to unpack .../12-libnginx-mod-http-geoip2_1.18.0-6ubuntu14.6_amd64.deb ...
Unpacking libnginx-mod-http-geoip2 (1.18.0-6ubuntu14.6) ...
Selecting previously unselected package libnginx-mod-http-image-filter.
Preparing to unpack .../13-libnginx-mod-http-image-filter_1.18.0-6ubuntu14.6_amd64.deb ...
Unpacking libnginx-mod-http-image-filter (1.18.0-6ubuntu14.6) ...
Selecting previously unselected package libnginx-mod-http-xslt-filter.
Preparing to unpack .../14-libnginx-mod-http-xslt-filter_1.18.0-6ubuntu14.6_amd64.deb ...
Unpacking libnginx-mod-http-xslt-filter (1.18.0-6ubuntu14.6) ...
Selecting previously unselected package libnginx-mod-mail.
Preparing to unpack .../15-libnginx-mod-mail_1.18.0-6ubuntu14.6_amd64.deb ...
Unpacking libnginx-mod-mail (1.18.0-6ubuntu14.6) ...
Selecting previously unselected package libnginx-mod-stream.
Preparing to unpack .../16-libnginx-mod-stream_1.18.0-6ubuntu14.6_amd64.deb ...
Unpacking libnginx-mod-stream (1.18.0-6ubuntu14.6) ...
Selecting previously unselected package libnginx-mod-stream-geoip2.
Preparing to unpack .../17-libnginx-mod-stream-geoip2_1.18.0-6ubuntu14.6_amd64.deb ...
Unpacking libnginx-mod-stream-geoip2 (1.18.0-6ubuntu14.6) ...
Selecting previously unselected package nginx-core.
Preparing to unpack .../18-nginx-core_1.18.0-6ubuntu14.6_amd64.deb ...
Unpacking nginx-core (1.18.0-6ubuntu14.6) ...
Selecting previously unselected package nginx.
Preparing to unpack .../19-nginx_1.18.0-6ubuntu14.6_amd64.deb ...
Unpacking nginx (1.18.0-6ubuntu14.6) ...
Setting up libxpm4:amd64 (1:3.5.12-1ubuntu0.22.04.2) ...
Setting up libdeflate0:amd64 (1.10-2) ...
Setting up nginx-common (1.18.0-6ubuntu14.6) ...
debconf: unable to initialize frontend: Dialog
debconf: (Dialog frontend will not work on a dumb terminal, an emacs shell buffer, or without a controlling terminal.)
debconf: falling back to frontend: Readline
Created symlink /etc/systemd/system/multi-user.target.wants/nginx.service → /lib/systemd/system/nginx.service.
Setting up libjbig0:amd64 (2.1-3.1ubuntu0.22.04.1) ...
Setting up libnginx-mod-http-xslt-filter (1.18.0-6ubuntu14.6) ...
Setting up fonts-dejavu-core (2.37-2build1) ...
Setting up libjpeg-turbo8:amd64 (2.1.2-0ubuntu1) ...
Setting up libwebp7:amd64 (1.2.2-2ubuntu0.22.04.2) ...
Setting up libnginx-mod-http-geoip2 (1.18.0-6ubuntu14.6) ...
Setting up libjpeg8:amd64 (8c-2ubuntu10) ...
Setting up libnginx-mod-mail (1.18.0-6ubuntu14.6) ...
Setting up fontconfig-config (2.13.1-4.2ubuntu5) ...
Setting up libnginx-mod-stream (1.18.0-6ubuntu14.6) ...
Setting up libtiff5:amd64 (4.3.0-6ubuntu0.10) ...
Setting up libfontconfig1:amd64 (2.13.1-4.2ubuntu5) ...
Setting up libnginx-mod-stream-geoip2 (1.18.0-6ubuntu14.6) ...
Setting up libgd3:amd64 (2.3.0-2ubuntu2.3) ...
Setting up libnginx-mod-http-image-filter (1.18.0-6ubuntu14.6) ...
Setting up nginx-core (1.18.0-6ubuntu14.6) ...
 * Upgrading binary nginx
   ...done.
Setting up nginx (1.18.0-6ubuntu14.6) ...
Processing triggers for ufw (0.36.1-4ubuntu0.1) ...
Processing triggers for man-db (2.10.2-1) ...
Processing triggers for libc-bin (2.35-0ubuntu3.10) ...

Running kernel seems to be up-to-date.

No services need to be restarted.

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
NGINX reverse proxy is now running at http://
Do you want to delete all created resources? (y/n): Enter the name of the resource group: Enter the name of the VM: Enter the admin username for the VM: Enter the name of the Network Security Group (NSG): Creating resource group...
{
  "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test",
  "location": "westeurope",
  "managedBy": null,
  "name": "test",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}
Resource group 'test' created successfully.
Using existing SSH key at /home/avichai98/.ssh/mynewkey
Creating VM...
true
Selecting "uksouth" may reduce your costs. The region you've selected may cost more for the same services. You can disable this message in the future with the command "az config set core.display_region_identified=false". Learn more at https://go.microsoft.com/fwlink/?linkid=222571 

{
  "fqdns": "",
  "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Compute/virtualMachines/avichai",
  "location": "westeurope",
  "macAddress": "60-45-BD-89-D6-99",
  "powerState": "VM running",
  "privateIpAddress": "10.0.0.4",
  "publicIpAddress": "172.201.0.34",
  "resourceGroup": "test",
  "zones": ""
}
VM 'avichai' created successfully in resource group 'test'.
Public IP address of the VM: 172.201.0.34
Checking for existing swap...
Warning: Permanently added '172.201.0.34' (ED25519) to the list of known hosts.
Creating 1GB swapfile at /swapfile...
Setting up swapspace version 1, size = 1024 MiB (1073737728 bytes)
no label, UUID=ac2de228-6f39-4706-8b99-e4daff245639
/swapfile none swap sw 0 0
Swapfile created and enabled.
Current swap status:
               total        used        free      shared  buff/cache   available
Mem:           345Mi       230Mi       7.0Mi       3.0Mi       107Mi        91Mi
Swap:          1.0Gi          0B       1.0Gi
Creating Network Security Group (NSG)...
{
  "NewNSG": {
    "defaultSecurityRules": [
      {
        "access": "Allow",
        "description": "Allow inbound traffic from all VMs in VNET",
        "destinationAddressPrefix": "VirtualNetwork",
        "destinationAddressPrefixes": [],
        "destinationPortRange": "*",
        "destinationPortRanges": [],
        "direction": "Inbound",
        "etag": "W/\"b0b973fe-e29a-47f0-916c-12ec0f6a7b78\"",
        "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/test/defaultSecurityRules/AllowVnetInBound",
        "name": "AllowVnetInBound",
        "priority": 65000,
        "protocol": "*",
        "provisioningState": "Succeeded",
        "resourceGroup": "test",
        "sourceAddressPrefix": "VirtualNetwork",
        "sourceAddressPrefixes": [],
        "sourcePortRange": "*",
        "sourcePortRanges": [],
        "type": "Microsoft.Network/networkSecurityGroups/defaultSecurityRules"
      },
      {
        "access": "Allow",
        "description": "Allow inbound traffic from azure load balancer",
        "destinationAddressPrefix": "*",
        "destinationAddressPrefixes": [],
        "destinationPortRange": "*",
        "destinationPortRanges": [],
        "direction": "Inbound",
        "etag": "W/\"b0b973fe-e29a-47f0-916c-12ec0f6a7b78\"",
        "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/test/defaultSecurityRules/AllowAzureLoadBalancerInBound",
        "name": "AllowAzureLoadBalancerInBound",
        "priority": 65001,
        "protocol": "*",
        "provisioningState": "Succeeded",
        "resourceGroup": "test",
        "sourceAddressPrefix": "AzureLoadBalancer",
        "sourceAddressPrefixes": [],
        "sourcePortRange": "*",
        "sourcePortRanges": [],
        "type": "Microsoft.Network/networkSecurityGroups/defaultSecurityRules"
      },
      {
        "access": "Deny",
        "description": "Deny all inbound traffic",
        "destinationAddressPrefix": "*",
        "destinationAddressPrefixes": [],
        "destinationPortRange": "*",
        "destinationPortRanges": [],
        "direction": "Inbound",
        "etag": "W/\"b0b973fe-e29a-47f0-916c-12ec0f6a7b78\"",
        "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/test/defaultSecurityRules/DenyAllInBound",
        "name": "DenyAllInBound",
        "priority": 65500,
        "protocol": "*",
        "provisioningState": "Succeeded",
        "resourceGroup": "test",
        "sourceAddressPrefix": "*",
        "sourceAddressPrefixes": [],
        "sourcePortRange": "*",
        "sourcePortRanges": [],
        "type": "Microsoft.Network/networkSecurityGroups/defaultSecurityRules"
      },
      {
        "access": "Allow",
        "description": "Allow outbound traffic from all VMs to all VMs in VNET",
        "destinationAddressPrefix": "VirtualNetwork",
        "destinationAddressPrefixes": [],
        "destinationPortRange": "*",
        "destinationPortRanges": [],
        "direction": "Outbound",
        "etag": "W/\"b0b973fe-e29a-47f0-916c-12ec0f6a7b78\"",
        "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/test/defaultSecurityRules/AllowVnetOutBound",
        "name": "AllowVnetOutBound",
        "priority": 65000,
        "protocol": "*",
        "provisioningState": "Succeeded",
        "resourceGroup": "test",
        "sourceAddressPrefix": "VirtualNetwork",
        "sourceAddressPrefixes": [],
        "sourcePortRange": "*",
        "sourcePortRanges": [],
        "type": "Microsoft.Network/networkSecurityGroups/defaultSecurityRules"
      },
      {
        "access": "Allow",
        "description": "Allow outbound traffic from all VMs to Internet",
        "destinationAddressPrefix": "Internet",
        "destinationAddressPrefixes": [],
        "destinationPortRange": "*",
        "destinationPortRanges": [],
        "direction": "Outbound",
        "etag": "W/\"b0b973fe-e29a-47f0-916c-12ec0f6a7b78\"",
        "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/test/defaultSecurityRules/AllowInternetOutBound",
        "name": "AllowInternetOutBound",
        "priority": 65001,
        "protocol": "*",
        "provisioningState": "Succeeded",
        "resourceGroup": "test",
        "sourceAddressPrefix": "*",
        "sourceAddressPrefixes": [],
        "sourcePortRange": "*",
        "sourcePortRanges": [],
        "type": "Microsoft.Network/networkSecurityGroups/defaultSecurityRules"
      },
      {
        "access": "Deny",
        "description": "Deny all outbound traffic",
        "destinationAddressPrefix": "*",
        "destinationAddressPrefixes": [],
        "destinationPortRange": "*",
        "destinationPortRanges": [],
        "direction": "Outbound",
        "etag": "W/\"b0b973fe-e29a-47f0-916c-12ec0f6a7b78\"",
        "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/test/defaultSecurityRules/DenyAllOutBound",
        "name": "DenyAllOutBound",
        "priority": 65500,
        "protocol": "*",
        "provisioningState": "Succeeded",
        "resourceGroup": "test",
        "sourceAddressPrefix": "*",
        "sourceAddressPrefixes": [],
        "sourcePortRange": "*",
        "sourcePortRanges": [],
        "type": "Microsoft.Network/networkSecurityGroups/defaultSecurityRules"
      }
    ],
    "etag": "W/\"b0b973fe-e29a-47f0-916c-12ec0f6a7b78\"",
    "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/test",
    "location": "westeurope",
    "name": "test",
    "provisioningState": "Succeeded",
    "resourceGroup": "test",
    "resourceGuid": "053fd392-cf48-42b9-8f04-bbf7049f9625",
    "securityRules": [],
    "type": "Microsoft.Network/networkSecurityGroups"
  }
}
NSG 'test' created successfully in resource group 'test'.
Creating Network Security Group (NSG) rules...
{
  "access": "Allow",
  "description": "Allow SSH",
  "destinationAddressPrefix": "*",
  "destinationAddressPrefixes": [],
  "destinationPortRange": "22",
  "destinationPortRanges": [],
  "direction": "Inbound",
  "etag": "W/\"123a85f1-1073-48a8-9dfe-bfaf6f5da3c0\"",
  "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/test/securityRules/AllowSSH",
  "name": "AllowSSH",
  "priority": 100,
  "protocol": "Tcp",
  "provisioningState": "Succeeded",
  "resourceGroup": "test",
  "sourceAddressPrefix": "*",
  "sourceAddressPrefixes": [],
  "sourcePortRange": "*",
  "sourcePortRanges": [],
  "type": "Microsoft.Network/networkSecurityGroups/securityRules"
}
{
  "access": "Allow",
  "description": "Allow inbound HTTP traffic on port 3000",
  "destinationAddressPrefix": "*",
  "destinationAddressPrefixes": [],
  "destinationPortRange": "3000",
  "destinationPortRanges": [],
  "direction": "Inbound",
  "etag": "W/\"406f0533-7c0d-446d-a7b2-19b0038d79cf\"",
  "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/test/securityRules/AllowHTTP",
  "name": "AllowHTTP",
  "priority": 1000,
  "protocol": "Tcp",
  "provisioningState": "Succeeded",
  "resourceGroup": "test",
  "sourceAddressPrefix": "*",
  "sourceAddressPrefixes": [],
  "sourcePortRange": "*",
  "sourcePortRanges": [],
  "type": "Microsoft.Network/networkSecurityGroups/securityRules"
}
NSG rule created.
{
  "access": "Allow",
  "description": "Allow inbound HTTP traffic on port 80",
  "destinationAddressPrefix": "*",
  "destinationAddressPrefixes": [],
  "destinationPortRange": "80",
  "destinationPortRanges": [],
  "direction": "Inbound",
  "etag": "W/\"3f3c0a7c-b25b-424f-8f17-7482abaea8a0\"",
  "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/test/securityRules/AllowHTTP",
  "name": "AllowHTTP",
  "priority": 1001,
  "protocol": "Tcp",
  "provisioningState": "Succeeded",
  "resourceGroup": "test",
  "sourceAddressPrefix": "*",
  "sourceAddressPrefixes": [],
  "sourcePortRange": "*",
  "sourcePortRanges": [],
  "type": "Microsoft.Network/networkSecurityGroups/securityRules"
}
NSG rule created.
Associating NSG with VM's network interface...
{
  "auxiliaryMode": "None",
  "auxiliarySku": "None",
  "disableTcpStateTracking": false,
  "dnsSettings": {
    "appliedDnsServers": [],
    "dnsServers": [],
    "internalDomainNameSuffix": "sge3afcxaykufk4ddo0j2irilf.ax.internal.cloudapp.net"
  },
  "enableAcceleratedNetworking": false,
  "enableIPForwarding": false,
  "etag": "W/\"d9c79eb9-4fca-4cc3-8c06-c2ca61b4d7f5\"",
  "hostedWorkloads": [],
  "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkInterfaces/avichaiVMNic",
  "ipConfigurations": [
    {
      "etag": "W/\"d9c79eb9-4fca-4cc3-8c06-c2ca61b4d7f5\"",
      "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkInterfaces/avichaiVMNic/ipConfigurations/ipconfigavichai",
      "name": "ipconfigavichai",
      "primary": true,
      "privateIPAddress": "10.0.0.4",
      "privateIPAddressVersion": "IPv4",
      "privateIPAllocationMethod": "Dynamic",
      "provisioningState": "Succeeded",
      "publicIPAddress": {
        "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/publicIPAddresses/avichaiPublicIP",
        "resourceGroup": "test"
      },
      "resourceGroup": "test",
      "subnet": {
        "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/virtualNetworks/avichaiVNET/subnets/avichaiSubnet",
        "resourceGroup": "test"
      },
      "type": "Microsoft.Network/networkInterfaces/ipConfigurations"
    }
  ],
  "location": "westeurope",
  "macAddress": "60-45-BD-89-D6-99",
  "name": "avichaiVMNic",
  "networkSecurityGroup": {
    "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/test",
    "resourceGroup": "test"
  },
  "nicType": "Standard",
  "primary": true,
  "provisioningState": "Succeeded",
  "resourceGroup": "test",
  "resourceGuid": "2673362c-8776-44b7-b90a-cfa1c99c04ff",
  "tags": {},
  "tapConfigurations": [],
  "type": "Microsoft.Network/networkInterfaces",
  "virtualMachine": {
    "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Compute/virtualMachines/avichai",
    "resourceGroup": "test"
  },
  "vnetEncryptionSupported": false
}
Creating Azure File Share...
{
  "accessTier": "Hot",
  "accountMigrationInProgress": null,
  "allowBlobPublicAccess": true,
  "allowCrossTenantReplication": false,
  "allowSharedKeyAccess": null,
  "allowedCopyScope": null,
  "azureFilesIdentityBasedAuthentication": null,
  "blobRestoreStatus": null,
  "creationTime": "2025-06-25T20:13:28.367384+00:00",
  "customDomain": null,
  "defaultToOAuthAuthentication": null,
  "dnsEndpointType": null,
  "enableExtendedGroups": null,
  "enableHttpsTrafficOnly": true,
  "enableNfsV3": null,
  "encryption": {
    "encryptionIdentity": null,
    "keySource": "Microsoft.Storage",
    "keyVaultProperties": null,
    "requireInfrastructureEncryption": null,
    "services": {
      "blob": {
        "enabled": true,
        "keyType": "Account",
        "lastEnabledTime": "2025-06-25T20:13:28.554879+00:00"
      },
      "file": {
        "enabled": true,
        "keyType": "Account",
        "lastEnabledTime": "2025-06-25T20:13:28.554879+00:00"
      },
      "queue": null,
      "table": null
    }
  },
  "extendedLocation": null,
  "failoverInProgress": null,
  "geoReplicationStats": null,
  "id": "/subscriptions/63e736f9-c77b-48e5-aeaf-853e4c7cc4d1/resourceGroups/test/providers/Microsoft.Storage/storageAccounts/teststor17334",
  "identity": null,
  "immutableStorageWithVersioning": null,
  "isHnsEnabled": false,
  "isLocalUserEnabled": null,
  "isSftpEnabled": null,
  "isSkuConversionBlocked": null,
  "keyCreationTime": {
    "key1": "2025-06-25T20:13:28.554879+00:00",
    "key2": "2025-06-25T20:13:28.554879+00:00"
  },
  "keyPolicy": null,
  "kind": "StorageV2",
  "largeFileSharesState": null,
  "lastGeoFailoverTime": null,
  "location": "westeurope",
  "minimumTlsVersion": "TLS1_2",
  "name": "teststor17334",
  "networkRuleSet": {
    "bypass": "AzureServices",
    "defaultAction": "Allow",
    "ipRules": [],
    "ipv6Rules": [],
    "resourceAccessRules": null,
    "virtualNetworkRules": []
  },
  "primaryEndpoints": {
    "blob": "https://teststor17334.blob.core.windows.net/",
    "dfs": "https://teststor17334.dfs.core.windows.net/",
    "file": "https://teststor17334.file.core.windows.net/",
    "internetEndpoints": null,
    "microsoftEndpoints": null,
    "queue": "https://teststor17334.queue.core.windows.net/",
    "table": "https://teststor17334.table.core.windows.net/",
    "web": "https://teststor17334.z6.web.core.windows.net/"
  },
  "primaryLocation": "westeurope",
  "privateEndpointConnections": [],
  "provisioningState": "Succeeded",
  "publicNetworkAccess": null,
  "resourceGroup": "test",
  "routingPreference": null,
  "sasPolicy": null,
  "secondaryEndpoints": null,
  "secondaryLocation": null,
  "sku": {
    "name": "Standard_LRS",
    "tier": "Standard"
  },
  "statusOfPrimary": "available",
  "statusOfSecondary": null,
  "storageAccountSkuConversionStatus": null,
  "tags": {},
  "type": "Microsoft.Storage/storageAccounts"
}
WARNING: 
There are no credentials provided in your command and environment, we will query for account key for your storage account.
It is recommended to provide --connection-string, --account-key or --sas-token in your command as credentials.

In addition, setting the corresponding environment variables can avoid inputting credentials in your command. Please use --help to get more information about environment variable usage.
{
  "created": true
}
Mounting file share on VM...
Pseudo-terminal will not be allocated because stdin is not a terminal.
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 6.8.0-1030-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Wed Jun 25 20:13:53 UTC 2025

  System load:  0.85              Processes:             110
  Usage of /:   8.9% of 28.89GB   Users logged in:       0
  Memory usage: 72%               IPv4 address for eth0: 10.0.0.4
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status

New release '24.04.2 LTS' available.
Run 'do-release-upgrade' to upgrade to it.



WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Hit:1 http://azure.archive.ubuntu.com/ubuntu jammy InRelease
Get:2 http://azure.archive.ubuntu.com/ubuntu jammy-updates InRelease [128 kB]
Get:3 http://azure.archive.ubuntu.com/ubuntu jammy-backports InRelease [127 kB]
Get:4 http://azure.archive.ubuntu.com/ubuntu jammy-security InRelease [129 kB]
Get:5 http://azure.archive.ubuntu.com/ubuntu jammy/universe amd64 Packages [14.1 MB]
Get:6 http://azure.archive.ubuntu.com/ubuntu jammy/universe Translation-en [5652 kB]
Get:7 http://azure.archive.ubuntu.com/ubuntu jammy/universe amd64 c-n-f Metadata [286 kB]
Get:8 http://azure.archive.ubuntu.com/ubuntu jammy/multiverse amd64 Packages [217 kB]
Get:9 http://azure.archive.ubuntu.com/ubuntu jammy/multiverse Translation-en [112 kB]
Get:10 http://azure.archive.ubuntu.com/ubuntu jammy/multiverse amd64 c-n-f Metadata [8372 B]
Get:11 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 Packages [2666 kB]
Get:12 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main Translation-en [429 kB]
Get:13 http://azure.archive.ubuntu.com/ubuntu jammy-updates/restricted amd64 Packages [3720 kB]
Get:14 http://azure.archive.ubuntu.com/ubuntu jammy-updates/restricted Translation-en [668 kB]
Get:15 http://azure.archive.ubuntu.com/ubuntu jammy-updates/universe amd64 Packages [1215 kB]
Get:16 http://azure.archive.ubuntu.com/ubuntu jammy-updates/universe Translation-en [300 kB]
Get:17 http://azure.archive.ubuntu.com/ubuntu jammy-updates/universe amd64 c-n-f Metadata [28.7 kB]
Get:18 http://azure.archive.ubuntu.com/ubuntu jammy-updates/multiverse amd64 Packages [46.5 kB]
Get:19 http://azure.archive.ubuntu.com/ubuntu jammy-updates/multiverse Translation-en [11.8 kB]
Get:20 http://azure.archive.ubuntu.com/ubuntu jammy-updates/multiverse amd64 c-n-f Metadata [592 B]
Get:21 http://azure.archive.ubuntu.com/ubuntu jammy-backports/main amd64 Packages [68.8 kB]
Get:22 http://azure.archive.ubuntu.com/ubuntu jammy-backports/main Translation-en [11.4 kB]
Get:23 http://azure.archive.ubuntu.com/ubuntu jammy-backports/main amd64 c-n-f Metadata [392 B]
Get:24 http://azure.archive.ubuntu.com/ubuntu jammy-backports/restricted amd64 c-n-f Metadata [116 B]
Get:25 http://azure.archive.ubuntu.com/ubuntu jammy-backports/universe amd64 Packages [30.0 kB]
Get:26 http://azure.archive.ubuntu.com/ubuntu jammy-backports/universe Translation-en [16.5 kB]
Get:27 http://azure.archive.ubuntu.com/ubuntu jammy-backports/universe amd64 c-n-f Metadata [672 B]
Get:28 http://azure.archive.ubuntu.com/ubuntu jammy-backports/multiverse amd64 c-n-f Metadata [116 B]
Get:29 http://azure.archive.ubuntu.com/ubuntu jammy-security/main amd64 Packages [2420 kB]
Get:30 http://azure.archive.ubuntu.com/ubuntu jammy-security/main Translation-en [365 kB]
Get:31 http://azure.archive.ubuntu.com/ubuntu jammy-security/restricted amd64 Packages [3595 kB]
Get:32 http://azure.archive.ubuntu.com/ubuntu jammy-security/restricted Translation-en [646 kB]
Get:33 http://azure.archive.ubuntu.com/ubuntu jammy-security/universe amd64 Packages [980 kB]
Get:34 http://azure.archive.ubuntu.com/ubuntu jammy-security/universe Translation-en [212 kB]
Get:35 http://azure.archive.ubuntu.com/ubuntu jammy-security/universe amd64 c-n-f Metadata [21.7 kB]
Get:36 http://azure.archive.ubuntu.com/ubuntu jammy-security/multiverse amd64 Packages [39.6 kB]
Get:37 http://azure.archive.ubuntu.com/ubuntu jammy-security/multiverse Translation-en [8716 B]
Get:38 http://azure.archive.ubuntu.com/ubuntu jammy-security/multiverse amd64 c-n-f Metadata [368 B]
Fetched 38.3 MB in 9s (4207 kB/s)
Reading package lists...
Building dependency tree...
Reading state information...
All packages are up to date.

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Reading package lists...
Building dependency tree...
Reading state information...
cifs-utils is already the newest version (2:6.14-1ubuntu0.3).
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
Transferring application files to the VM...
Connecting to VM and deploying the application...
Pseudo-terminal will not be allocated because stdin is not a terminal.
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 6.8.0-1030-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Wed Jun 25 20:13:53 UTC 2025

  System load:  0.85              Processes:             110
  Usage of /:   8.9% of 28.89GB   Users logged in:       0
  Memory usage: 72%               IPv4 address for eth0: 10.0.0.4
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status

New release '24.04.2 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


Connected to VM.
Installing Docker...

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Hit:1 http://azure.archive.ubuntu.com/ubuntu jammy InRelease
Hit:2 http://azure.archive.ubuntu.com/ubuntu jammy-updates InRelease
Hit:3 http://azure.archive.ubuntu.com/ubuntu jammy-backports InRelease
Hit:4 http://azure.archive.ubuntu.com/ubuntu jammy-security InRelease
Reading package lists...
Building dependency tree...
Reading state information...
All packages are up to date.

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Reading package lists...
Building dependency tree...
Reading state information...
ca-certificates is already the newest version (20240203~22.04.1).
ca-certificates set to manually installed.
curl is already the newest version (7.81.0-1ubuntu1.20).
curl set to manually installed.
gnupg is already the newest version (2.2.27-3ubuntu2.3).
gnupg set to manually installed.
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Hit:1 http://azure.archive.ubuntu.com/ubuntu jammy InRelease
Hit:2 http://azure.archive.ubuntu.com/ubuntu jammy-updates InRelease
Hit:3 http://azure.archive.ubuntu.com/ubuntu jammy-backports InRelease
Hit:4 http://azure.archive.ubuntu.com/ubuntu jammy-security InRelease
Get:5 https://download.docker.com/linux/ubuntu jammy InRelease [48.8 kB]
Get:6 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages [51.9 kB]
Fetched 101 kB in 1s (101 kB/s)
Reading package lists...
Building dependency tree...
Reading state information...
All packages are up to date.

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Reading package lists...
Building dependency tree...
Reading state information...
The following additional packages will be installed:
  docker-ce-rootless-extras libltdl7 libslirp0 pigz slirp4netns
Suggested packages:
  cgroupfs-mount | cgroup-lite docker-model-plugin
The following NEW packages will be installed:
  containerd.io docker-buildx-plugin docker-ce docker-ce-cli
  docker-ce-rootless-extras docker-compose-plugin libltdl7 libslirp0 pigz
  slirp4netns
0 upgraded, 10 newly installed, 0 to remove and 0 not upgraded.
Need to get 103 MB of archives.
After this operation, 429 MB of additional disk space will be used.
Get:1 http://azure.archive.ubuntu.com/ubuntu jammy/universe amd64 pigz amd64 2.6-1 [63.6 kB]
Get:2 http://azure.archive.ubuntu.com/ubuntu jammy/main amd64 libltdl7 amd64 2.4.6-15build2 [39.6 kB]
Get:3 http://azure.archive.ubuntu.com/ubuntu jammy/main amd64 libslirp0 amd64 4.6.1-1build1 [61.5 kB]
Get:4 http://azure.archive.ubuntu.com/ubuntu jammy/universe amd64 slirp4netns amd64 1.0.1-2 [28.2 kB]
Get:5 https://download.docker.com/linux/ubuntu jammy/stable amd64 containerd.io amd64 1.7.27-1 [30.5 MB]
Get:6 https://download.docker.com/linux/ubuntu jammy/stable amd64 docker-ce-cli amd64 5:28.3.0-1~ubuntu.22.04~jammy [16.5 MB]
Get:7 https://download.docker.com/linux/ubuntu jammy/stable amd64 docker-ce amd64 5:28.3.0-1~ubuntu.22.04~jammy [19.7 MB]
Get:8 https://download.docker.com/linux/ubuntu jammy/stable amd64 docker-buildx-plugin amd64 0.25.0-1~ubuntu.22.04~jammy [15.6 MB]
Get:9 https://download.docker.com/linux/ubuntu jammy/stable amd64 docker-ce-rootless-extras amd64 5:28.3.0-1~ubuntu.22.04~jammy [6480 kB]
Get:10 https://download.docker.com/linux/ubuntu jammy/stable amd64 docker-compose-plugin amd64 2.37.3-1~ubuntu.22.04~jammy [14.2 MB]
debconf: unable to initialize frontend: Dialog
debconf: (Dialog frontend will not work on a dumb terminal, an emacs shell buffer, or without a controlling terminal.)
debconf: falling back to frontend: Readline
debconf: unable to initialize frontend: Readline
debconf: (This frontend requires a controlling tty.)
debconf: falling back to frontend: Teletype
dpkg-preconfigure: unable to re-open stdin: 
Fetched 103 MB in 5s (22.2 MB/s)
Selecting previously unselected package containerd.io.
(Reading database ... (Reading database ... 5%(Reading database ... 10%(Reading database ... 15%(Reading database ... 20%(Reading database ... 25%(Reading database ... 30%(Reading database ... 35%(Reading database ... 40%(Reading database ... 45%(Reading database ... 50%(Reading database ... 55%(Reading database ... 60%(Reading database ... 65%(Reading database ... 70%(Reading database ... 75%(Reading database ... 80%(Reading database ... 85%(Reading database ... 90%(Reading database ... 95%(Reading database ... 100%(Reading database ... 62805 files and directories currently installed.)
Preparing to unpack .../0-containerd.io_1.7.27-1_amd64.deb ...
Unpacking containerd.io (1.7.27-1) ...
Selecting previously unselected package docker-ce-cli.
Preparing to unpack .../1-docker-ce-cli_5%3a28.3.0-1~ubuntu.22.04~jammy_amd64.deb ...
Unpacking docker-ce-cli (5:28.3.0-1~ubuntu.22.04~jammy) ...
Selecting previously unselected package docker-ce.
Preparing to unpack .../2-docker-ce_5%3a28.3.0-1~ubuntu.22.04~jammy_amd64.deb ...
Unpacking docker-ce (5:28.3.0-1~ubuntu.22.04~jammy) ...
Selecting previously unselected package pigz.
Preparing to unpack .../3-pigz_2.6-1_amd64.deb ...
Unpacking pigz (2.6-1) ...
Selecting previously unselected package docker-buildx-plugin.
Preparing to unpack .../4-docker-buildx-plugin_0.25.0-1~ubuntu.22.04~jammy_amd64.deb ...
Unpacking docker-buildx-plugin (0.25.0-1~ubuntu.22.04~jammy) ...
Selecting previously unselected package docker-ce-rootless-extras.
Preparing to unpack .../5-docker-ce-rootless-extras_5%3a28.3.0-1~ubuntu.22.04~jammy_amd64.deb ...
Unpacking docker-ce-rootless-extras (5:28.3.0-1~ubuntu.22.04~jammy) ...
Selecting previously unselected package docker-compose-plugin.
Preparing to unpack .../6-docker-compose-plugin_2.37.3-1~ubuntu.22.04~jammy_amd64.deb ...
Unpacking docker-compose-plugin (2.37.3-1~ubuntu.22.04~jammy) ...
Selecting previously unselected package libltdl7:amd64.
Preparing to unpack .../7-libltdl7_2.4.6-15build2_amd64.deb ...
Unpacking libltdl7:amd64 (2.4.6-15build2) ...
Selecting previously unselected package libslirp0:amd64.
Preparing to unpack .../8-libslirp0_4.6.1-1build1_amd64.deb ...
Unpacking libslirp0:amd64 (4.6.1-1build1) ...
Selecting previously unselected package slirp4netns.
Preparing to unpack .../9-slirp4netns_1.0.1-2_amd64.deb ...
Unpacking slirp4netns (1.0.1-2) ...
Setting up docker-buildx-plugin (0.25.0-1~ubuntu.22.04~jammy) ...
Setting up containerd.io (1.7.27-1) ...
Created symlink /etc/systemd/system/multi-user.target.wants/containerd.service → /lib/systemd/system/containerd.service.
Setting up docker-compose-plugin (2.37.3-1~ubuntu.22.04~jammy) ...
Setting up libltdl7:amd64 (2.4.6-15build2) ...
Setting up docker-ce-cli (5:28.3.0-1~ubuntu.22.04~jammy) ...
Setting up libslirp0:amd64 (4.6.1-1build1) ...
Setting up pigz (2.6-1) ...
Setting up docker-ce-rootless-extras (5:28.3.0-1~ubuntu.22.04~jammy) ...
Setting up slirp4netns (1.0.1-2) ...
Setting up docker-ce (5:28.3.0-1~ubuntu.22.04~jammy) ...
Created symlink /etc/systemd/system/multi-user.target.wants/docker.service → /lib/systemd/system/docker.service.
Created symlink /etc/systemd/system/sockets.target.wants/docker.socket → /lib/systemd/system/docker.socket.
Processing triggers for man-db (2.10.2-1) ...
Processing triggers for libc-bin (2.35-0ubuntu3.10) ...

Running kernel seems to be up-to-date.

No services need to be restarted.

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.
Running the application...
time="2025-06-25T20:15:54Z" level=warning msg="/home/avichai98/week8/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion"
 mongo Pulling 
 d9d352c11bbd Pulling fs layer 
 0a4282d2a9c9 Pulling fs layer 
 e88cb4c0b31e Pulling fs layer 
 06b43d55bbbc Pulling fs layer 
 697905244caf Pulling fs layer 
 ebd0c6090698 Pulling fs layer 
 3e961522d85c Pulling fs layer 
 35581a5e0588 Pulling fs layer 
 06b43d55bbbc Waiting 
 697905244caf Waiting 
 ebd0c6090698 Waiting 
 3e961522d85c Waiting 
 35581a5e0588 Waiting 
 0a4282d2a9c9 Downloading [======================================>            ]     933B/1.216kB
 0a4282d2a9c9 Downloading [==================================================>]  1.216kB/1.216kB
 0a4282d2a9c9 Verifying Checksum 
 0a4282d2a9c9 Download complete 
 e88cb4c0b31e Downloading [>                                                  ]  15.85kB/1.509MB
 d9d352c11bbd Downloading [>                                                  ]  306.6kB/29.72MB
 e88cb4c0b31e Verifying Checksum 
 e88cb4c0b31e Download complete 
 d9d352c11bbd Downloading [=====>                                             ]  3.374MB/29.72MB
 06b43d55bbbc Downloading [>                                                  ]  11.88kB/1.131MB
 d9d352c11bbd Downloading [======>                                            ]  3.984MB/29.72MB
 697905244caf Downloading [==================================================>]     116B/116B
 697905244caf Verifying Checksum 
 697905244caf Download complete 
 06b43d55bbbc Downloading [====================>                              ]  474.6kB/1.131MB
 d9d352c11bbd Downloading [=======>                                           ]  4.606MB/29.72MB
 06b43d55bbbc Downloading [=====================================>             ]  859.6kB/1.131MB
 06b43d55bbbc Verifying Checksum 
 06b43d55bbbc Download complete 
 ebd0c6090698 Downloading [==================================================>]     262B/262B
 ebd0c6090698 Verifying Checksum 
 ebd0c6090698 Download complete 
 d9d352c11bbd Downloading [========>                                          ]  5.225MB/29.72MB
 d9d352c11bbd Downloading [=========>                                         ]  5.847MB/29.72MB
 35581a5e0588 Downloading [=============>                                     ]  1.369kB/5kB
 35581a5e0588 Downloading [==================================================>]      5kB/5kB
 35581a5e0588 Verifying Checksum 
 35581a5e0588 Download complete 
 d9d352c11bbd Downloading [==========>                                        ]   6.47MB/29.72MB
 3e961522d85c Downloading [>                                                  ]  539.1kB/259.8MB
 d9d352c11bbd Downloading [=============>                                     ]  8.022MB/29.72MB
 3e961522d85c Downloading [>                                                  ]  3.763MB/259.8MB
 d9d352c11bbd Downloading [========================>                          ]  14.47MB/29.72MB
 3e961522d85c Downloading [==>                                                ]  10.72MB/259.8MB
 d9d352c11bbd Downloading [=====================================>             ]  22.46MB/29.72MB
 3e961522d85c Downloading [===>                                               ]  18.25MB/259.8MB
 d9d352c11bbd Downloading [========================================>          ]  24.33MB/29.72MB
 3e961522d85c Downloading [=====>                                             ]   27.9MB/259.8MB
 d9d352c11bbd Verifying Checksum 
 d9d352c11bbd Download complete 
 3e961522d85c Downloading [=====>                                             ]  29.52MB/259.8MB
 3e961522d85c Downloading [======>                                            ]   32.2MB/259.8MB
 3e961522d85c Downloading [=======>                                           ]  39.22MB/259.8MB
 d9d352c11bbd Extracting [>                                                  ]  327.7kB/29.72MB
 3e961522d85c Downloading [=========>                                         ]   49.4MB/259.8MB
 3e961522d85c Downloading [===========>                                       ]  62.29MB/259.8MB
 d9d352c11bbd Extracting [=>                                                 ]    983kB/29.72MB
 3e961522d85c Downloading [==============>                                    ]  77.39MB/259.8MB
 3e961522d85c Downloading [================>                                  ]   85.4MB/259.8MB
 d9d352c11bbd Extracting [==>                                                ]  1.638MB/29.72MB
 3e961522d85c Downloading [=================>                                 ]  88.61MB/259.8MB
 3e961522d85c Downloading [=================>                                 ]  93.44MB/259.8MB
 3e961522d85c Downloading [==================>                                ]  96.12MB/259.8MB
 d9d352c11bbd Extracting [===>                                               ]  1.966MB/29.72MB
 3e961522d85c Downloading [===================>                               ]  103.1MB/259.8MB
 d9d352c11bbd Extracting [====>                                              ]  2.621MB/29.72MB
 3e961522d85c Downloading [======================>                            ]  114.4MB/259.8MB
 3e961522d85c Downloading [======================>                            ]  118.1MB/259.8MB
 d9d352c11bbd Extracting [====>                                              ]  2.949MB/29.72MB
 3e961522d85c Downloading [=======================>                           ]    124MB/259.8MB
 d9d352c11bbd Extracting [=====>                                             ]  3.277MB/29.72MB
 3e961522d85c Downloading [==========================>                        ]  136.9MB/259.8MB
 d9d352c11bbd Extracting [======>                                            ]  3.604MB/29.72MB
 3e961522d85c Downloading [============================>                      ]  147.1MB/259.8MB
 d9d352c11bbd Extracting [======>                                            ]  3.932MB/29.72MB
 3e961522d85c Downloading [=============================>                     ]  154.1MB/259.8MB
 3e961522d85c Downloading [===============================>                   ]  165.3MB/259.8MB
 d9d352c11bbd Extracting [=======>                                           ]   4.26MB/29.72MB
 3e961522d85c Downloading [=================================>                 ]    176MB/259.8MB
 d9d352c11bbd Extracting [=======>                                           ]  4.588MB/29.72MB
 3e961522d85c Downloading [==================================>                ]  179.3MB/259.8MB
 3e961522d85c Downloading [===================================>               ]  186.2MB/259.8MB
 d9d352c11bbd Extracting [========>                                          ]  4.915MB/29.72MB
 3e961522d85c Downloading [====================================>              ]  189.5MB/259.8MB
 d9d352c11bbd Extracting [=========>                                         ]  5.571MB/29.72MB
 3e961522d85c Downloading [=====================================>             ]  195.9MB/259.8MB
 3e961522d85c Downloading [=======================================>           ]  202.9MB/259.8MB
 d9d352c11bbd Extracting [==========>                                        ]  6.226MB/29.72MB
 3e961522d85c Downloading [========================================>          ]    211MB/259.8MB
 3e961522d85c Downloading [==========================================>        ]  220.7MB/259.8MB
 d9d352c11bbd Extracting [===========>                                       ]  6.554MB/29.72MB
 3e961522d85c Downloading [============================================>      ]  229.8MB/259.8MB
 3e961522d85c Downloading [=============================================>     ]  237.9MB/259.8MB
 d9d352c11bbd Extracting [===========>                                       ]  6.881MB/29.72MB
 3e961522d85c Downloading [===============================================>   ]    247MB/259.8MB
 3e961522d85c Downloading [================================================>  ]  253.4MB/259.8MB
 d9d352c11bbd Extracting [============>                                      ]  7.209MB/29.72MB
 3e961522d85c Verifying Checksum 
 3e961522d85c Download complete 
 d9d352c11bbd Extracting [=============>                                     ]  7.864MB/29.72MB
 d9d352c11bbd Extracting [==============>                                    ]   8.52MB/29.72MB
 d9d352c11bbd Extracting [===============>                                   ]  9.503MB/29.72MB
 d9d352c11bbd Extracting [================>                                  ]   9.83MB/29.72MB
 d9d352c11bbd Extracting [====================>                              ]  12.12MB/29.72MB
 d9d352c11bbd Extracting [========================>                          ]  14.75MB/29.72MB
 d9d352c11bbd Extracting [=============================>                     ]  17.69MB/29.72MB
 d9d352c11bbd Extracting [==================================>                ]  20.64MB/29.72MB
 d9d352c11bbd Extracting [=======================================>           ]  23.27MB/29.72MB
 d9d352c11bbd Extracting [==========================================>        ]  25.23MB/29.72MB
 d9d352c11bbd Extracting [===========================================>       ]  25.56MB/29.72MB
 d9d352c11bbd Extracting [==============================================>    ]  27.85MB/29.72MB
 d9d352c11bbd Extracting [=================================================> ]  29.16MB/29.72MB
 d9d352c11bbd Extracting [==================================================>]  29.72MB/29.72MB
 d9d352c11bbd Pull complete 
 0a4282d2a9c9 Extracting [==================================================>]  1.216kB/1.216kB
 0a4282d2a9c9 Extracting [==================================================>]  1.216kB/1.216kB
 0a4282d2a9c9 Pull complete 
 e88cb4c0b31e Extracting [=>                                                 ]  32.77kB/1.509MB
 e88cb4c0b31e Extracting [=========>                                         ]  294.9kB/1.509MB
 e88cb4c0b31e Extracting [======================================>            ]  1.147MB/1.509MB
 e88cb4c0b31e Extracting [==========================================>        ]  1.278MB/1.509MB
 e88cb4c0b31e Extracting [==================================================>]  1.509MB/1.509MB
 e88cb4c0b31e Pull complete 
 06b43d55bbbc Extracting [=>                                                 ]  32.77kB/1.131MB
 06b43d55bbbc Extracting [=======>                                           ]  163.8kB/1.131MB
 06b43d55bbbc Extracting [============================>                      ]  655.4kB/1.131MB
 06b43d55bbbc Extracting [==================================================>]  1.131MB/1.131MB
 06b43d55bbbc Extracting [==================================================>]  1.131MB/1.131MB
 06b43d55bbbc Pull complete 
 697905244caf Extracting [==================================================>]     116B/116B
 697905244caf Extracting [==================================================>]     116B/116B
 697905244caf Pull complete 
 ebd0c6090698 Extracting [==================================================>]     262B/262B
 ebd0c6090698 Extracting [==================================================>]     262B/262B
 ebd0c6090698 Pull complete 
 3e961522d85c Extracting [>                                                  ]  557.1kB/259.8MB
 3e961522d85c Extracting [>                                                  ]  3.342MB/259.8MB
 3e961522d85c Extracting [=>                                                 ]  8.356MB/259.8MB
 3e961522d85c Extracting [=>                                                 ]  10.03MB/259.8MB
 3e961522d85c Extracting [==>                                                ]  10.58MB/259.8MB
 3e961522d85c Extracting [==>                                                ]  11.14MB/259.8MB
 3e961522d85c Extracting [==>                                                ]  12.81MB/259.8MB
 3e961522d85c Extracting [==>                                                ]  15.04MB/259.8MB
 3e961522d85c Extracting [===>                                               ]   19.5MB/259.8MB
 3e961522d85c Extracting [===>                                               ]  20.61MB/259.8MB
 3e961522d85c Extracting [====>                                              ]  22.84MB/259.8MB
 3e961522d85c Extracting [====>                                              ]  23.95MB/259.8MB
 3e961522d85c Extracting [=====>                                             ]   27.3MB/259.8MB
 3e961522d85c Extracting [=====>                                             ]  29.52MB/259.8MB
 3e961522d85c Extracting [======>                                            ]   31.2MB/259.8MB
 3e961522d85c Extracting [======>                                            ]  33.42MB/259.8MB
 3e961522d85c Extracting [======>                                            ]  36.21MB/259.8MB
 3e961522d85c Extracting [=======>                                           ]  37.88MB/259.8MB
 3e961522d85c Extracting [=======>                                           ]  41.22MB/259.8MB
 3e961522d85c Extracting [========>                                          ]  44.01MB/259.8MB
 3e961522d85c Extracting [========>                                          ]  45.12MB/259.8MB
 3e961522d85c Extracting [=========>                                         ]  47.35MB/259.8MB
 3e961522d85c Extracting [=========>                                         ]  49.02MB/259.8MB
 3e961522d85c Extracting [=========>                                         ]  51.81MB/259.8MB
 3e961522d85c Extracting [==========>                                        ]  53.48MB/259.8MB
 3e961522d85c Extracting [==========>                                        ]  56.26MB/259.8MB
 3e961522d85c Extracting [===========>                                       ]  59.05MB/259.8MB
 3e961522d85c Extracting [===========>                                       ]   59.6MB/259.8MB
 3e961522d85c Extracting [===========>                                       ]  61.83MB/259.8MB
 3e961522d85c Extracting [============>                                      ]  62.39MB/259.8MB
 3e961522d85c Extracting [============>                                      ]  62.95MB/259.8MB
 3e961522d85c Extracting [============>                                      ]  64.06MB/259.8MB
 3e961522d85c Extracting [============>                                      ]  64.62MB/259.8MB
 3e961522d85c Extracting [============>                                      ]  65.73MB/259.8MB
 3e961522d85c Extracting [============>                                      ]  66.29MB/259.8MB
 3e961522d85c Extracting [=============>                                     ]  69.07MB/259.8MB
 3e961522d85c Extracting [==============>                                    ]  73.53MB/259.8MB
 3e961522d85c Extracting [==============>                                    ]  76.87MB/259.8MB
 3e961522d85c Extracting [===============>                                   ]   79.1MB/259.8MB
 3e961522d85c Extracting [================>                                  ]  84.12MB/259.8MB
 3e961522d85c Extracting [================>                                  ]  85.79MB/259.8MB
 3e961522d85c Extracting [================>                                  ]  88.01MB/259.8MB
 3e961522d85c Extracting [=================>                                 ]  93.03MB/259.8MB
 3e961522d85c Extracting [==================>                                ]  95.26MB/259.8MB
 3e961522d85c Extracting [==================>                                ]  98.04MB/259.8MB
 3e961522d85c Extracting [===================>                               ]  102.5MB/259.8MB
 3e961522d85c Extracting [====================>                              ]  105.3MB/259.8MB
 3e961522d85c Extracting [====================>                              ]  107.5MB/259.8MB
 3e961522d85c Extracting [====================>                              ]  108.6MB/259.8MB
 3e961522d85c Extracting [=====================>                             ]  112.5MB/259.8MB
 3e961522d85c Extracting [=====================>                             ]  113.6MB/259.8MB
 3e961522d85c Extracting [=====================>                             ]  114.2MB/259.8MB
 3e961522d85c Extracting [======================>                            ]  114.8MB/259.8MB
 3e961522d85c Extracting [======================>                            ]  115.9MB/259.8MB
 3e961522d85c Extracting [======================>                            ]    117MB/259.8MB
 3e961522d85c Extracting [=======================>                           ]  120.3MB/259.8MB
 3e961522d85c Extracting [=======================>                           ]  121.4MB/259.8MB
 3e961522d85c Extracting [========================>                          ]  124.8MB/259.8MB
 3e961522d85c Extracting [========================>                          ]  125.3MB/259.8MB
 3e961522d85c Extracting [========================>                          ]  128.1MB/259.8MB
 3e961522d85c Extracting [========================>                          ]  129.2MB/259.8MB
 3e961522d85c Extracting [=========================>                         ]  132.6MB/259.8MB
 3e961522d85c Extracting [==========================>                        ]  135.4MB/259.8MB
 3e961522d85c Extracting [==========================>                        ]  136.5MB/259.8MB
 3e961522d85c Extracting [==========================>                        ]  139.8MB/259.8MB
 3e961522d85c Extracting [===========================>                       ]  141.5MB/259.8MB
 3e961522d85c Extracting [===========================>                       ]  143.7MB/259.8MB
 3e961522d85c Extracting [============================>                      ]  146.5MB/259.8MB
 3e961522d85c Extracting [============================>                      ]  147.6MB/259.8MB
 3e961522d85c Extracting [=============================>                     ]    151MB/259.8MB
 3e961522d85c Extracting [=============================>                     ]  153.2MB/259.8MB
 3e961522d85c Extracting [=============================>                     ]  153.7MB/259.8MB
 3e961522d85c Extracting [=============================>                     ]  154.3MB/259.8MB
 3e961522d85c Extracting [=============================>                     ]  154.9MB/259.8MB
 3e961522d85c Extracting [==============================>                    ]    156MB/259.8MB
 3e961522d85c Extracting [==============================>                    ]  158.2MB/259.8MB
 3e961522d85c Extracting [==============================>                    ]    161MB/259.8MB
 3e961522d85c Extracting [===============================>                   ]  163.8MB/259.8MB
 3e961522d85c Extracting [================================>                  ]  167.1MB/259.8MB
 3e961522d85c Extracting [================================>                  ]  168.2MB/259.8MB
 3e961522d85c Extracting [================================>                  ]    171MB/259.8MB
 3e961522d85c Extracting [=================================>                 ]  171.6MB/259.8MB
 3e961522d85c Extracting [=================================>                 ]  173.8MB/259.8MB
 3e961522d85c Extracting [=================================>                 ]  174.9MB/259.8MB
 3e961522d85c Extracting [==================================>                ]  177.1MB/259.8MB
 3e961522d85c Extracting [==================================>                ]  179.4MB/259.8MB
 3e961522d85c Extracting [==================================>                ]  180.5MB/259.8MB
 3e961522d85c Extracting [==================================>                ]    181MB/259.8MB
 3e961522d85c Extracting [==================================>                ]  181.6MB/259.8MB
 3e961522d85c Extracting [===================================>               ]  185.5MB/259.8MB
 3e961522d85c Extracting [===================================>               ]  186.6MB/259.8MB
 3e961522d85c Extracting [====================================>              ]  188.8MB/259.8MB
 3e961522d85c Extracting [====================================>              ]  191.1MB/259.8MB
 3e961522d85c Extracting [=====================================>             ]  192.7MB/259.8MB
 3e961522d85c Extracting [=====================================>             ]  195.5MB/259.8MB
 3e961522d85c Extracting [======================================>            ]  199.4MB/259.8MB
 3e961522d85c Extracting [======================================>            ]  200.5MB/259.8MB
 3e961522d85c Extracting [======================================>            ]  202.2MB/259.8MB
 3e961522d85c Extracting [=======================================>           ]  203.3MB/259.8MB
 3e961522d85c Extracting [=======================================>           ]  204.4MB/259.8MB
 3e961522d85c Extracting [=======================================>           ]  207.8MB/259.8MB
 3e961522d85c Extracting [========================================>          ]  208.3MB/259.8MB
 3e961522d85c Extracting [=========================================>         ]  213.9MB/259.8MB
 3e961522d85c Extracting [=========================================>         ]  216.7MB/259.8MB
 3e961522d85c Extracting [==========================================>        ]  221.2MB/259.8MB
 3e961522d85c Extracting [==========================================>        ]  222.3MB/259.8MB
 3e961522d85c Extracting [===========================================>       ]  224.5MB/259.8MB
 3e961522d85c Extracting [============================================>      ]    229MB/259.8MB
 3e961522d85c Extracting [============================================>      ]  231.7MB/259.8MB
 3e961522d85c Extracting [=============================================>     ]  235.1MB/259.8MB
 3e961522d85c Extracting [=============================================>     ]  237.3MB/259.8MB
 3e961522d85c Extracting [=============================================>     ]    239MB/259.8MB
 3e961522d85c Extracting [==============================================>    ]  242.3MB/259.8MB
 3e961522d85c Extracting [===============================================>   ]  245.1MB/259.8MB
 3e961522d85c Extracting [===============================================>   ]  246.2MB/259.8MB
 3e961522d85c Extracting [================================================>  ]  249.6MB/259.8MB
 3e961522d85c Extracting [================================================>  ]  251.8MB/259.8MB
 3e961522d85c Extracting [================================================>  ]    254MB/259.8MB
 3e961522d85c Extracting [=================================================> ]  255.1MB/259.8MB
 3e961522d85c Extracting [=================================================> ]  255.7MB/259.8MB
 3e961522d85c Extracting [=================================================> ]  256.2MB/259.8MB
 3e961522d85c Extracting [=================================================> ]  256.8MB/259.8MB
 3e961522d85c Extracting [=================================================> ]    259MB/259.8MB
 3e961522d85c Extracting [=================================================> ]  259.6MB/259.8MB
 3e961522d85c Extracting [==================================================>]  259.8MB/259.8MB
 3e961522d85c Pull complete 
 35581a5e0588 Extracting [==================================================>]      5kB/5kB
 35581a5e0588 Extracting [==================================================>]      5kB/5kB
 35581a5e0588 Pull complete 
 mongo Pulled 
#1 [internal] load local bake definitions
#1 reading from stdin 642B done
#1 DONE 0.0s

#2 [backend internal] load build definition from Dockerfile
#2 transferring dockerfile:
#2 transferring dockerfile: 669B 0.1s done
#2 DONE 0.5s

#3 [frontend internal] load build definition from Dockerfile
#3 transferring dockerfile: 181B 0.0s done
#3 DONE 0.6s

#4 [frontend internal] load metadata for docker.io/library/node:20-alpine
#4 ...

#5 [backend internal] load metadata for docker.io/library/python:3.11-slim
#5 DONE 1.9s

#4 [frontend internal] load metadata for docker.io/library/node:20-alpine
#4 DONE 2.0s

#6 [backend internal] load .dockerignore
#6 transferring context: 100B 0.0s done
#6 DONE 0.3s

#7 [frontend internal] load .dockerignore
#7 transferring context: 2B 0.0s done
#7 DONE 0.3s

#8 [backend 1/5] FROM docker.io/library/python:3.11-slim@sha256:9e1912aab0a30bbd9488eb79063f68f42a68ab0946cbe98fecf197fe5b085506
#8 ...

#9 [backend internal] load build context
#9 DONE 0.0s

#8 [backend 1/5] FROM docker.io/library/python:3.11-slim@sha256:9e1912aab0a30bbd9488eb79063f68f42a68ab0946cbe98fecf197fe5b085506
#8 resolve docker.io/library/python:3.11-slim@sha256:9e1912aab0a30bbd9488eb79063f68f42a68ab0946cbe98fecf197fe5b085506
#8 resolve docker.io/library/python:3.11-slim@sha256:9e1912aab0a30bbd9488eb79063f68f42a68ab0946cbe98fecf197fe5b085506 0.3s done
#8 ...

#10 [frontend internal] load build context
#10 transferring context: 110.08kB 0.1s done
#10 DONE 0.4s

#8 [backend 1/5] FROM docker.io/library/python:3.11-slim@sha256:9e1912aab0a30bbd9488eb79063f68f42a68ab0946cbe98fecf197fe5b085506
#8 sha256:cfa2a40862158178855ab4f7cf6b9341646f826b0467a7b72bdeac68b03986bb 1.75kB / 1.75kB done
#8 sha256:9e1912aab0a30bbd9488eb79063f68f42a68ab0946cbe98fecf197fe5b085506 9.13kB / 9.13kB done
#8 sha256:be3324b8ee1a17161c5fa4a20f310d4af42cbb4f22a1e7a32a98ee9196a6defd 5.37kB / 5.37kB done
#8 sha256:dad67da3f26bce15939543965e09c4059533b025f707aad72ed3d3f3a09c66f8 0B / 28.23MB 0.1s
#8 ...

#9 [backend internal] load build context
#9 transferring context: 1.20kB 0.0s done
#9 DONE 0.4s

#8 [backend 1/5] FROM docker.io/library/python:3.11-slim@sha256:9e1912aab0a30bbd9488eb79063f68f42a68ab0946cbe98fecf197fe5b085506
#8 sha256:dad67da3f26bce15939543965e09c4059533b025f707aad72ed3d3f3a09c66f8 11.53MB / 28.23MB 0.3s
#8 sha256:9596beeb5a6dc0950529870568799000e8d73fb678969ac2f485005cd5da1087 0B / 16.21MB 0.3s
#8 sha256:799440a7bae7c08a5fe9d9e5a1ccd72fc3cbf9d85fa4be450e12b8550175c620 0B / 3.51MB 0.3s
#8 sha256:dad67da3f26bce15939543965e09c4059533b025f707aad72ed3d3f3a09c66f8 19.92MB / 28.23MB 0.4s
#8 sha256:9596beeb5a6dc0950529870568799000e8d73fb678969ac2f485005cd5da1087 2.10MB / 16.21MB 0.4s
#8 sha256:dad67da3f26bce15939543965e09c4059533b025f707aad72ed3d3f3a09c66f8 26.21MB / 28.23MB 0.6s
#8 sha256:9596beeb5a6dc0950529870568799000e8d73fb678969ac2f485005cd5da1087 8.39MB / 16.21MB 0.6s
#8 sha256:dad67da3f26bce15939543965e09c4059533b025f707aad72ed3d3f3a09c66f8 28.23MB / 28.23MB 1.2s
#8 sha256:9596beeb5a6dc0950529870568799000e8d73fb678969ac2f485005cd5da1087 12.58MB / 16.21MB 1.2s
#8 sha256:799440a7bae7c08a5fe9d9e5a1ccd72fc3cbf9d85fa4be450e12b8550175c620 2.10MB / 3.51MB 1.2s
#8 sha256:dad67da3f26bce15939543965e09c4059533b025f707aad72ed3d3f3a09c66f8 28.23MB / 28.23MB 1.2s done
#8 sha256:9596beeb5a6dc0950529870568799000e8d73fb678969ac2f485005cd5da1087 14.68MB / 16.21MB 1.3s
#8 sha256:799440a7bae7c08a5fe9d9e5a1ccd72fc3cbf9d85fa4be450e12b8550175c620 3.51MB / 3.51MB 1.3s
#8 sha256:9596beeb5a6dc0950529870568799000e8d73fb678969ac2f485005cd5da1087 16.21MB / 16.21MB 1.5s
#8 sha256:9596beeb5a6dc0950529870568799000e8d73fb678969ac2f485005cd5da1087 16.21MB / 16.21MB 1.6s done
#8 sha256:15658014cd85cd0d8b913d50b4388228aebcf0437d43cfb37e8a5177e8b2bcf8 0B / 248B 1.6s
#8 extracting sha256:dad67da3f26bce15939543965e09c4059533b025f707aad72ed3d3f3a09c66f8
#8 sha256:799440a7bae7c08a5fe9d9e5a1ccd72fc3cbf9d85fa4be450e12b8550175c620 3.51MB / 3.51MB 1.7s done
#8 sha256:15658014cd85cd0d8b913d50b4388228aebcf0437d43cfb37e8a5177e8b2bcf8 248B / 248B 1.8s done
#8 extracting sha256:dad67da3f26bce15939543965e09c4059533b025f707aad72ed3d3f3a09c66f8 5.1s done
#8 extracting sha256:799440a7bae7c08a5fe9d9e5a1ccd72fc3cbf9d85fa4be450e12b8550175c620
#8 extracting sha256:799440a7bae7c08a5fe9d9e5a1ccd72fc3cbf9d85fa4be450e12b8550175c620 0.9s done
#8 extracting sha256:9596beeb5a6dc0950529870568799000e8d73fb678969ac2f485005cd5da1087
#8 ...

#11 [frontend 1/5] FROM docker.io/library/node:20-alpine@sha256:674181320f4f94582c6182eaa151bf92c6744d478be0f1d12db804b7d59b2d11
#11 resolve docker.io/library/node:20-alpine@sha256:674181320f4f94582c6182eaa151bf92c6744d478be0f1d12db804b7d59b2d11 0.4s done
#11 sha256:674181320f4f94582c6182eaa151bf92c6744d478be0f1d12db804b7d59b2d11 7.67kB / 7.67kB done
#11 sha256:6d6b06f970b08f9ebbe65a5561c20e8623d6afa612ea035bbbe38fb78dd94b14 1.72kB / 1.72kB done
#11 sha256:bfd94ebedbdada46a3d3447f6bc2de4d271021b3a45a76821cca6afa361ea94d 6.21kB / 6.21kB done
#11 sha256:fe07684b16b82247c3539ed86a65ff37a76138ec25d380bd80c869a1a4c73236 3.80MB / 3.80MB 1.9s done
#11 sha256:5432aa916e0868c8c9385ef60226d5ef530f13fe7c28fc13c054de1df6d006cd 42.99MB / 42.99MB 3.2s done
#11 sha256:2506673f55362e86b6c8a2ab9c01541ae636887386c92d06e01286d3ddd83871 1.26MB / 1.26MB 3.0s done
#11 extracting sha256:fe07684b16b82247c3539ed86a65ff37a76138ec25d380bd80c869a1a4c73236 1.2s done
#11 sha256:98c4889b578e94078411d6c14fe8f5daa0303d43e82bbf84d5787ab657c42428 445B / 445B 3.2s done
#11 extracting sha256:5432aa916e0868c8c9385ef60226d5ef530f13fe7c28fc13c054de1df6d006cd 4.9s
#11 ...

#8 [backend 1/5] FROM docker.io/library/python:3.11-slim@sha256:9e1912aab0a30bbd9488eb79063f68f42a68ab0946cbe98fecf197fe5b085506
#8 extracting sha256:9596beeb5a6dc0950529870568799000e8d73fb678969ac2f485005cd5da1087 4.0s done
#8 extracting sha256:15658014cd85cd0d8b913d50b4388228aebcf0437d43cfb37e8a5177e8b2bcf8 done
#8 ...

#11 [frontend 1/5] FROM docker.io/library/node:20-alpine@sha256:674181320f4f94582c6182eaa151bf92c6744d478be0f1d12db804b7d59b2d11
#11 extracting sha256:5432aa916e0868c8c9385ef60226d5ef530f13fe7c28fc13c054de1df6d006cd 6.0s done
#11 extracting sha256:2506673f55362e86b6c8a2ab9c01541ae636887386c92d06e01286d3ddd83871 0.4s done
#11 extracting sha256:98c4889b578e94078411d6c14fe8f5daa0303d43e82bbf84d5787ab657c42428 done
#11 DONE 13.9s

#12 [frontend 2/5] WORKDIR /app
#12 ...

#8 [backend 1/5] FROM docker.io/library/python:3.11-slim@sha256:9e1912aab0a30bbd9488eb79063f68f42a68ab0946cbe98fecf197fe5b085506
#8 DONE 14.3s

#12 [frontend 2/5] WORKDIR /app
#12 DONE 0.3s

#13 [backend 2/5] WORKDIR /app
#13 DONE 0.4s

#14 [frontend 3/5] COPY package.json package-lock.json* ./
#14 DONE 0.6s

#15 [backend 3/5] COPY app.py .
#15 DONE 0.6s

#16 [frontend 4/5] RUN npm install
#16 ...

#17 [backend 4/5] COPY requirements.txt .
#17 DONE 0.7s

#18 [backend 5/5] RUN pip install --no-cache-dir -r requirements.txt
#18 26.76 Collecting Flask==3.1.1 (from -r requirements.txt (line 1))
#18 26.81   Downloading flask-3.1.1-py3-none-any.whl.metadata (3.0 kB)
#18 26.81 Collecting flask-cors==6.0.1 (from -r requirements.txt (line 2))
#18 26.81   Downloading flask_cors-6.0.1-py3-none-any.whl.metadata (5.3 kB)
#18 27.85 Collecting pymongo==4.13.2 (from -r requirements.txt (line 3))
#18 27.85   Downloading pymongo-4.13.2-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (22 kB)
#18 28.40 Collecting blinker>=1.9.0 (from Flask==3.1.1->-r requirements.txt (line 1))
#18 28.40   Downloading blinker-1.9.0-py3-none-any.whl.metadata (1.6 kB)
#18 28.40 Collecting click>=8.1.3 (from Flask==3.1.1->-r requirements.txt (line 1))
#18 28.40   Downloading click-8.2.1-py3-none-any.whl.metadata (2.5 kB)
#18 28.40 Collecting itsdangerous>=2.2.0 (from Flask==3.1.1->-r requirements.txt (line 1))
#18 28.40   Downloading itsdangerous-2.2.0-py3-none-any.whl.metadata (1.9 kB)
#18 28.40 Collecting jinja2>=3.1.2 (from Flask==3.1.1->-r requirements.txt (line 1))
#18 28.40   Downloading jinja2-3.1.6-py3-none-any.whl.metadata (2.9 kB)
#18 32.24 Collecting markupsafe>=2.1.1 (from Flask==3.1.1->-r requirements.txt (line 1))
#18 32.26   Downloading MarkupSafe-3.0.2-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (4.0 kB)
#18 32.31 Collecting werkzeug>=3.1.0 (from Flask==3.1.1->-r requirements.txt (line 1))
#18 32.32   Downloading werkzeug-3.1.3-py3-none-any.whl.metadata (3.7 kB)
#18 32.48 Collecting dnspython<3.0.0,>=1.16.0 (from pymongo==4.13.2->-r requirements.txt (line 3))
#18 32.49   Downloading dnspython-2.7.0-py3-none-any.whl.metadata (5.8 kB)
#18 32.60 Downloading flask-3.1.1-py3-none-any.whl (103 kB)
#18 ...

#16 [frontend 4/5] RUN npm install
#16 33.67 
#16 33.67 added 155 packages, and audited 156 packages in 24s
#16 33.67 
#16 33.67 33 packages are looking for funding
#16 33.67   run `npm fund` for details
#16 33.77 
#16 33.77 found 0 vulnerabilities
#16 33.93 npm notice
#16 33.93 npm notice New major version of npm available! 10.8.2 -> 11.4.2
#16 33.93 npm notice Changelog: https://github.com/npm/cli/releases/tag/v11.4.2
#16 33.93 npm notice To update run: npm install -g npm@11.4.2
#16 33.93 npm notice
#16 DONE 36.3s

#18 [backend 5/5] RUN pip install --no-cache-dir -r requirements.txt
#18 32.75    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 103.3/103.3 kB 46.8 MB/s eta 0:00:00
#18 32.79 Downloading flask_cors-6.0.1-py3-none-any.whl (13 kB)
#18 32.80 Downloading pymongo-4.13.2-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (1.4 MB)
#18 32.86    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.4/1.4 MB 112.6 MB/s eta 0:00:00
#18 32.90 Downloading blinker-1.9.0-py3-none-any.whl (8.5 kB)
#18 32.90 Downloading click-8.2.1-py3-none-any.whl (102 kB)
#18 32.90    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 102.2/102.2 kB 201.9 MB/s eta 0:00:00
#18 32.90 Downloading dnspython-2.7.0-py3-none-any.whl (313 kB)
#18 32.90    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 313.6/313.6 kB 169.4 MB/s eta 0:00:00
#18 32.90 Downloading itsdangerous-2.2.0-py3-none-any.whl (16 kB)
#18 32.90 Downloading jinja2-3.1.6-py3-none-any.whl (134 kB)
#18 32.90    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 134.9/134.9 kB 254.7 MB/s eta 0:00:00
#18 32.90 Downloading MarkupSafe-3.0.2-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (23 kB)
#18 32.91 Downloading werkzeug-3.1.3-py3-none-any.whl (224 kB)
#18 33.09    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 224.5/224.5 kB 54.7 MB/s eta 0:00:00
#18 33.43 Installing collected packages: markupsafe, itsdangerous, dnspython, click, blinker, werkzeug, pymongo, jinja2, Flask, flask-cors
#18 ...

#19 [frontend 5/5] COPY . .
#19 DONE 6.3s

#18 [backend 5/5] RUN pip install --no-cache-dir -r requirements.txt
#18 ...

#20 [frontend] exporting to image
#20 exporting layers
#20 ...

#18 [backend 5/5] RUN pip install --no-cache-dir -r requirements.txt
#18 42.96 Successfully installed Flask-3.1.1 blinker-1.9.0 click-8.2.1 dnspython-2.7.0 flask-cors-6.0.1 itsdangerous-2.2.0 jinja2-3.1.6 markupsafe-3.0.2 pymongo-4.13.2 werkzeug-3.1.3
#18 43.07 WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
#18 49.01 
#18 49.01 [notice] A new release of pip is available: 24.0 -> 25.1.1
#18 49.01 [notice] To update, run: pip install --upgrade pip
#18 DONE 96.3s

#20 [frontend] exporting to image
#20 ...

#21 [backend] exporting to image
#21 exporting layers
#21 exporting layers 18.2s done
#21 writing image sha256:6ce524c1c35b17ce55125a9fabdf472bbce391a32ed39a54b4cc7ee5ab5acb01 0.1s done
#21 naming to docker.io/library/week8-backend 0.3s done
#21 DONE 18.9s

#20 [frontend] exporting to image
#20 ...

#22 [backend] resolving provenance for metadata file
#22 DONE 0.7s

#20 [frontend] exporting to image
#20 exporting layers 82.1s done
#20 writing image sha256:8303e4462916a75ef3e8b43b042fb75839253a2e54dcd646a99c9e9042eb2603 0.0s done
#20 naming to docker.io/library/week8-frontend 0.0s done
#20 DONE 82.3s

#23 [frontend] resolving provenance for metadata file
#23 DONE 0.1s
 backend  Built
 frontend  Built
 Network week8_mynet  Creating
 Network week8_mynet  Created
 Volume "week8_mongodb_data"  Creating
 Volume "week8_mongodb_data"  Created
 Container my_mongo  Creating
 Container my_mongo  Created
 Container my_backend  Creating
 Container my_backend  Created
 Container my_frontend  Creating
 Container my_frontend  Created
 Container my_mongo  Starting
 Container my_mongo  Started
 Container my_backend  Starting
 Container my_backend  Started
 Container my_frontend  Starting
 Container my_frontend  Started
Application is running. You can access it at http://172.201.0.34:3000
Installing and configuring NGINX as reverse proxy...
Pseudo-terminal will not be allocated because stdin is not a terminal.
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 6.8.0-1030-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Wed Jun 25 20:13:53 UTC 2025

  System load:  0.85              Processes:             110
  Usage of /:   8.9% of 28.89GB   Users logged in:       0
  Memory usage: 72%               IPv4 address for eth0: 10.0.0.4
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status

New release '24.04.2 LTS' available.
Run 'do-release-upgrade' to upgrade to it.



WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Hit:1 http://azure.archive.ubuntu.com/ubuntu jammy InRelease
Hit:2 http://azure.archive.ubuntu.com/ubuntu jammy-updates InRelease
Hit:3 http://azure.archive.ubuntu.com/ubuntu jammy-backports InRelease
Hit:4 http://azure.archive.ubuntu.com/ubuntu jammy-security InRelease
Hit:5 https://download.docker.com/linux/ubuntu jammy InRelease
Reading package lists...
Building dependency tree...
Reading state information...
All packages are up to date.

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Reading package lists...
Building dependency tree...
Reading state information...
The following additional packages will be installed:
  fontconfig-config fonts-dejavu-core libdeflate0 libfontconfig1 libgd3
  libjbig0 libjpeg-turbo8 libjpeg8 libnginx-mod-http-geoip2
  libnginx-mod-http-image-filter libnginx-mod-http-xslt-filter
  libnginx-mod-mail libnginx-mod-stream libnginx-mod-stream-geoip2 libtiff5
  libwebp7 libxpm4 nginx-common nginx-core
Suggested packages:
  libgd-tools fcgiwrap nginx-doc ssl-cert
The following NEW packages will be installed:
  fontconfig-config fonts-dejavu-core libdeflate0 libfontconfig1 libgd3
  libjbig0 libjpeg-turbo8 libjpeg8 libnginx-mod-http-geoip2
  libnginx-mod-http-image-filter libnginx-mod-http-xslt-filter
  libnginx-mod-mail libnginx-mod-stream libnginx-mod-stream-geoip2 libtiff5
  libwebp7 libxpm4 nginx nginx-common nginx-core
0 upgraded, 20 newly installed, 0 to remove and 0 not upgraded.
Need to get 2693 kB of archives.
After this operation, 8346 kB of additional disk space will be used.
Get:1 http://azure.archive.ubuntu.com/ubuntu jammy/main amd64 fonts-dejavu-core all 2.37-2build1 [1041 kB]
Get:2 http://azure.archive.ubuntu.com/ubuntu jammy/main amd64 fontconfig-config all 2.13.1-4.2ubuntu5 [29.1 kB]
Get:3 http://azure.archive.ubuntu.com/ubuntu jammy/main amd64 libdeflate0 amd64 1.10-2 [70.9 kB]
Get:4 http://azure.archive.ubuntu.com/ubuntu jammy/main amd64 libfontconfig1 amd64 2.13.1-4.2ubuntu5 [131 kB]
Get:5 http://azure.archive.ubuntu.com/ubuntu jammy/main amd64 libjpeg-turbo8 amd64 2.1.2-0ubuntu1 [134 kB]
Get:6 http://azure.archive.ubuntu.com/ubuntu jammy/main amd64 libjpeg8 amd64 8c-2ubuntu10 [2264 B]
Get:7 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libjbig0 amd64 2.1-3.1ubuntu0.22.04.1 [29.2 kB]
Get:8 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libwebp7 amd64 1.2.2-2ubuntu0.22.04.2 [206 kB]
Get:9 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libtiff5 amd64 4.3.0-6ubuntu0.10 [185 kB]
Get:10 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libxpm4 amd64 1:3.5.12-1ubuntu0.22.04.2 [36.7 kB]
Get:11 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libgd3 amd64 2.3.0-2ubuntu2.3 [129 kB]
Get:12 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 nginx-common all 1.18.0-6ubuntu14.6 [40.1 kB]
Get:13 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libnginx-mod-http-geoip2 amd64 1.18.0-6ubuntu14.6 [12.0 kB]
Get:14 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libnginx-mod-http-image-filter amd64 1.18.0-6ubuntu14.6 [15.5 kB]
Get:15 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libnginx-mod-http-xslt-filter amd64 1.18.0-6ubuntu14.6 [13.8 kB]
Get:16 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libnginx-mod-mail amd64 1.18.0-6ubuntu14.6 [45.8 kB]
Get:17 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libnginx-mod-stream amd64 1.18.0-6ubuntu14.6 [73.0 kB]
Get:18 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 libnginx-mod-stream-geoip2 amd64 1.18.0-6ubuntu14.6 [10.1 kB]
Get:19 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 nginx-core amd64 1.18.0-6ubuntu14.6 [483 kB]
Get:20 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 nginx amd64 1.18.0-6ubuntu14.6 [3882 B]
debconf: unable to initialize frontend: Dialog
debconf: (Dialog frontend will not work on a dumb terminal, an emacs shell buffer, or without a controlling terminal.)
debconf: falling back to frontend: Readline
debconf: unable to initialize frontend: Readline
debconf: (This frontend requires a controlling tty.)
debconf: falling back to frontend: Teletype
dpkg-preconfigure: unable to re-open stdin: 
Fetched 2693 kB in 0s (11.2 MB/s)
Selecting previously unselected package fonts-dejavu-core.
(Reading database ... (Reading database ... 5%(Reading database ... 10%(Reading database ... 15%(Reading database ... 20%(Reading database ... 25%(Reading database ... 30%(Reading database ... 35%(Reading database ... 40%(Reading database ... 45%(Reading database ... 50%(Reading database ... 55%(Reading database ... 60%(Reading database ... 65%(Reading database ... 70%(Reading database ... 75%(Reading database ... 80%(Reading database ... 85%(Reading database ... 90%(Reading database ... 95%(Reading database ... 100%(Reading database ... 63072 files and directories currently installed.)
Preparing to unpack .../00-fonts-dejavu-core_2.37-2build1_all.deb ...
Unpacking fonts-dejavu-core (2.37-2build1) ...
Selecting previously unselected package fontconfig-config.
Preparing to unpack .../01-fontconfig-config_2.13.1-4.2ubuntu5_all.deb ...
Unpacking fontconfig-config (2.13.1-4.2ubuntu5) ...
Selecting previously unselected package libdeflate0:amd64.
Preparing to unpack .../02-libdeflate0_1.10-2_amd64.deb ...
Unpacking libdeflate0:amd64 (1.10-2) ...
Selecting previously unselected package libfontconfig1:amd64.
Preparing to unpack .../03-libfontconfig1_2.13.1-4.2ubuntu5_amd64.deb ...
Unpacking libfontconfig1:amd64 (2.13.1-4.2ubuntu5) ...
Selecting previously unselected package libjpeg-turbo8:amd64.
Preparing to unpack .../04-libjpeg-turbo8_2.1.2-0ubuntu1_amd64.deb ...
Unpacking libjpeg-turbo8:amd64 (2.1.2-0ubuntu1) ...
Selecting previously unselected package libjpeg8:amd64.
Preparing to unpack .../05-libjpeg8_8c-2ubuntu10_amd64.deb ...
Unpacking libjpeg8:amd64 (8c-2ubuntu10) ...
Selecting previously unselected package libjbig0:amd64.
Preparing to unpack .../06-libjbig0_2.1-3.1ubuntu0.22.04.1_amd64.deb ...
Unpacking libjbig0:amd64 (2.1-3.1ubuntu0.22.04.1) ...
Selecting previously unselected package libwebp7:amd64.
Preparing to unpack .../07-libwebp7_1.2.2-2ubuntu0.22.04.2_amd64.deb ...
Unpacking libwebp7:amd64 (1.2.2-2ubuntu0.22.04.2) ...
Selecting previously unselected package libtiff5:amd64.
Preparing to unpack .../08-libtiff5_4.3.0-6ubuntu0.10_amd64.deb ...
Unpacking libtiff5:amd64 (4.3.0-6ubuntu0.10) ...
Selecting previously unselected package libxpm4:amd64.
Preparing to unpack .../09-libxpm4_1%3a3.5.12-1ubuntu0.22.04.2_amd64.deb ...
Unpacking libxpm4:amd64 (1:3.5.12-1ubuntu0.22.04.2) ...
Selecting previously unselected package libgd3:amd64.
Preparing to unpack .../10-libgd3_2.3.0-2ubuntu2.3_amd64.deb ...
Unpacking libgd3:amd64 (2.3.0-2ubuntu2.3) ...
Selecting previously unselected package nginx-common.
Preparing to unpack .../11-nginx-common_1.18.0-6ubuntu14.6_all.deb ...
Unpacking nginx-common (1.18.0-6ubuntu14.6) ...
Selecting previously unselected package libnginx-mod-http-geoip2.
Preparing to unpack .../12-libnginx-mod-http-geoip2_1.18.0-6ubuntu14.6_amd64.deb ...
Unpacking libnginx-mod-http-geoip2 (1.18.0-6ubuntu14.6) ...
Selecting previously unselected package libnginx-mod-http-image-filter.
Preparing to unpack .../13-libnginx-mod-http-image-filter_1.18.0-6ubuntu14.6_amd64.deb ...
Unpacking libnginx-mod-http-image-filter (1.18.0-6ubuntu14.6) ...
Selecting previously unselected package libnginx-mod-http-xslt-filter.
Preparing to unpack .../14-libnginx-mod-http-xslt-filter_1.18.0-6ubuntu14.6_amd64.deb ...
Unpacking libnginx-mod-http-xslt-filter (1.18.0-6ubuntu14.6) ...
Selecting previously unselected package libnginx-mod-mail.
Preparing to unpack .../15-libnginx-mod-mail_1.18.0-6ubuntu14.6_amd64.deb ...
Unpacking libnginx-mod-mail (1.18.0-6ubuntu14.6) ...
Selecting previously unselected package libnginx-mod-stream.
Preparing to unpack .../16-libnginx-mod-stream_1.18.0-6ubuntu14.6_amd64.deb ...
Unpacking libnginx-mod-stream (1.18.0-6ubuntu14.6) ...
Selecting previously unselected package libnginx-mod-stream-geoip2.
Preparing to unpack .../17-libnginx-mod-stream-geoip2_1.18.0-6ubuntu14.6_amd64.deb ...
Unpacking libnginx-mod-stream-geoip2 (1.18.0-6ubuntu14.6) ...
Selecting previously unselected package nginx-core.
Preparing to unpack .../18-nginx-core_1.18.0-6ubuntu14.6_amd64.deb ...
Unpacking nginx-core (1.18.0-6ubuntu14.6) ...
Selecting previously unselected package nginx.
Preparing to unpack .../19-nginx_1.18.0-6ubuntu14.6_amd64.deb ...
Unpacking nginx (1.18.0-6ubuntu14.6) ...
Setting up libxpm4:amd64 (1:3.5.12-1ubuntu0.22.04.2) ...
Setting up libdeflate0:amd64 (1.10-2) ...
Setting up nginx-common (1.18.0-6ubuntu14.6) ...
debconf: unable to initialize frontend: Dialog
debconf: (Dialog frontend will not work on a dumb terminal, an emacs shell buffer, or without a controlling terminal.)
debconf: falling back to frontend: Readline
Created symlink /etc/systemd/system/multi-user.target.wants/nginx.service → /lib/systemd/system/nginx.service.
Setting up libjbig0:amd64 (2.1-3.1ubuntu0.22.04.1) ...
Setting up libnginx-mod-http-xslt-filter (1.18.0-6ubuntu14.6) ...
Setting up fonts-dejavu-core (2.37-2build1) ...
Setting up libjpeg-turbo8:amd64 (2.1.2-0ubuntu1) ...
Setting up libwebp7:amd64 (1.2.2-2ubuntu0.22.04.2) ...
Setting up libnginx-mod-http-geoip2 (1.18.0-6ubuntu14.6) ...
Setting up libjpeg8:amd64 (8c-2ubuntu10) ...
Setting up libnginx-mod-mail (1.18.0-6ubuntu14.6) ...
Setting up fontconfig-config (2.13.1-4.2ubuntu5) ...
Setting up libnginx-mod-stream (1.18.0-6ubuntu14.6) ...
Setting up libtiff5:amd64 (4.3.0-6ubuntu0.10) ...
Setting up libfontconfig1:amd64 (2.13.1-4.2ubuntu5) ...
Setting up libnginx-mod-stream-geoip2 (1.18.0-6ubuntu14.6) ...
Setting up libgd3:amd64 (2.3.0-2ubuntu2.3) ...
Setting up libnginx-mod-http-image-filter (1.18.0-6ubuntu14.6) ...
Setting up nginx-core (1.18.0-6ubuntu14.6) ...
 * Upgrading binary nginx
   ...done.
Setting up nginx (1.18.0-6ubuntu14.6) ...
Processing triggers for ufw (0.36.1-4ubuntu0.1) ...
Processing triggers for man-db (2.10.2-1) ...
Processing triggers for libc-bin (2.35-0ubuntu3.10) ...

Running kernel seems to be up-to-date.

No services need to be restarted.

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
NGINX reverse proxy is now running at http://
Do you want to delete all created resources? (y/n): 