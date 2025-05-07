# Week 1 – DevOps & Linux Basics: Theory & Practice Tasks

## 📚 Theory Tasks

### 🔁 Agile Methodology and DevOps

Agile is a way to develop software step by step, with lots of teamwork and flexibility. It helps DevOps by encouraging small, frequent changes and quick feedback between developers and operations teams.

**How Agile and DevOps work together:**
- Agile focuses on building the software in short cycles.
- DevOps adds deployment, testing, and monitoring into that cycle, making the whole process smoother.

### 🗂 Linux File System – Key Folders Explained

- `/` – The **root folder**. Everything on the system starts from here.
- `/etc` – Contains system **configuration files** (like network settings and user info).
- `/var` – Stores **variable data** that changes often, like:
  - system **logs**
  - **emails**
  - **print jobs**
  - and **spool** files – temporary files waiting to be processed (for example, print queue files).
- `/home` – Each user gets a personal folder here. For example: `/home/user1`.

These folders help organize the system and make sure each part (like configs, logs, and user data) is easy to find and manage.

### 🚀 Why DevOps is Useful (With Real Examples)

1. **Faster Releases**
   - *Example:* Amazon can release new code every 11.7 seconds thanks to DevOps automation.
2. **Better Teamwork**
   - *Example:* Netflix lets developers manage their own infrastructure using DevOps tools.
3. **More Reliable Software**
   - *Example:* Google uses Site Reliability Engineering (SRE) to keep systems up and running smoothly.

---

## 🛠 Practice Tasks

### 📁 Navigating and Managing Directories

```bash
pwd
ls
cd /tmp
mkdir testdir
rm -r testdir
```

These commands help you move around the system and create/delete folders.

### 👤 Creating Users and Assigning to a Group

```bash
sudo adduser user1
sudo adduser user2
sudo addgroup devgroup
sudo usermod -aG devgroup user1
sudo usermod -aG devgroup user2
```

You create users and a group, then add the users to that group.

### 🔐 Changing File and Directory Permissions

```bash
touch devfile.txt
sudo chown :devgroup devfile.txt
sudo chmod 660 devfile.txt
```

In this example:
- The file `devfile.txt` is owned by the group `devgroup`.
- `chmod 660` means:
  - The **owner** can read and write.
  - The **group** can read and write.
  - **Others** have no access.

---
