# Week 1 Summary Task – DevOps & Linux Basics

## Part 1: Creating Directory Structure & Permissions

Creating the main directory inside my user (project1) and its subdirectories (scripts, docs):
```bash
mkdir -p project1/docs project1/scripts
```
This command creates the directory along with its subdirectories in one step. The `-p` flag ensures that if the parent directory (`project1`) does not exist, it will be created automatically.

### Permissions
X (Execute) = 1, R (Read) = 4, W (Write) = 2  
Using this key, we define file or folder permissions.  
The decimal numbers are essentially a conversion from binary representation.  

For example:  
- `rwx`: If all permissions are granted, we get 111 in binary, which equals 7 in base 10.  
- `r-x`: 101 in binary, which equals 5 in base 10.  

Setting permissions for the scripts directory:
```bash
chmod 744 scripts
```
This command grants full permissions to the main user, while others can only read.

Setting permissions for the docs directory:
```bash
chmod 777 docs
```
This command grants full permissions to everyone.

## Part 2: User & Group Management

Adding the user devuser:
```bash
sudo adduser devuser
```
This command adds a new user to the system. It then prompts for additional details, including password setup. The `sudo` command allows execution with root privileges.

Adding the group devteam:
```bash
sudo addgroup devteam
```
This command creates a new group.

Adding the user devuser to the devteam group:
```bash
sudo usermod -aG devteam devuser
```
This command assigns the user to the group. The `-aG` flag ensures that the user remains in all previously assigned groups.

Linking the project1 directory with the devteam group:
```bash
sudo chown root:devteam project1
```
This command assigns access to the devteam group.

Setting read-only permission for the devteam group on the project1 directory:
```bash
sudo chmod 750 project1
```
The root user has full permissions.  
The devteam group has read-only access.  
Other users have no permissions.

## Screenshots attached
1. `ls -lR project1.png`  
2. `groups devuser.png`
