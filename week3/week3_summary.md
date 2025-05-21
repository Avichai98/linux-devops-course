# 📦 Week 3 – Summary Task: Remote Log Monitor and Analyzer via SSH

This project provides a professional Bash script that connects to a remote server over SSH, retrieves logs (including compressed ones), scans for specific keywords like `ERROR`, `WARNING`, `CRITICAL`, and generates both human-readable and CSV reports.

---

## 🧩 Script Name
`remote_log_analyzer.sh`

---

## 🚀 Features

- 🔑 Connect to remote VM via SSH (key-based authentication)
- 📂 Supports `.log`, `.zip`, `.tar.gz` formats (auto extraction)
- 🔍 Searches for keywords and counts them across files
- 📄 Outputs to:
  - `remote_report_<timestamp>.txt` (pretty)
  - `remote_report_<timestamp>.csv` (Excel-ready)
- 📧 Optional: Send results via email (`--email`)
- 🔁 Optional: Search recursively in subdirectories (`--recursive`)
- ⏱ Displays total execution time
- 🧩 Built-in help menu (`--help`)

---

## 🛠️ Usage

```bash
./remote_log_analyzer.sh <user@host> <remote_log_directory> [OPTIONS]
```

### 🔧 Options:

| Option         | Description |
|----------------|-------------|
| `--keywords`   | List of words to search (e.g., `ERROR WARNING CRITICAL`) |
| `--email`      | Email address to send the summary |
| `--recursive`  | Recursively search inside subdirectories |
| `--help`       | Display usage instructions |

---

## 💡 Example

```bash
./remote_log_analyzer.sh azureuser@52.123.4.5 /var/log/app --keywords ERROR WARNING --email you@example.com --recursive
```

---

## 📂 Output Files (Saved under `logs_report/`)

- ✅ `remote_report_<timestamp>.txt`
- ✅ `remote_report_<timestamp>.csv`
- 📁 Extracted files go to: `logs_report/extracted_logs/`

---

## 🔒 Authentication

This script uses SSH **key-based authentication only**. Ensure you can connect to the remote VM with:

```bash
ssh user@host
```

If not, use your `ssh-copy-id` or `az vm user update` to copy the public key.

---

## ✉️ Email Setup (WSL/Gmail)

To enable `--email` on WSL:

1. Install:
```bash
sudo apt install msmtp msmtp-mta mailutils
```

2. Create `~/.msmtprc`:
```ini
defaults
auth on
tls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
logfile ~/.msmtp.log

account gmail
host smtp.gmail.com
port 587
from your_email@gmail.com
user your_email@gmail.com
password your_app_password

account default : gmail
```

3. Protect config:
```bash
chmod 600 ~/.msmtprc
```

4. Test:
```bash
echo "Hello from WSL" | mail -s "Test Email" your_email@gmail.com
```

---

## ⏱ Sample Output (TXT)

```
Scanning logs_report/azureuser/app1.log ...
| Keyword   | Occurrences |
|-----------|-------------|
| INFO      | 2           |
| ERROR     | 7           |
```

---

## 📎 Notes

- Make sure remote log folder exists and is accessible.
- Script handles compressed logs: `.zip`, `.tar.gz`
- Execution time printed at end
- Errors are handled gracefully

---

## ✅ Required Tools

- `ssh`, `scp`
- `grep`, `tar`, `unzip`
- `mail` (`mailutils`)
- `msmtp` (for working email in WSL)

---

## 📁 Folder Structure

```
week3_summary/
├── remote_log_analyzer.sh
├── logs_report/
│   ├── remote_report_<timestamp>.txt
│   ├── remote_report_<timestamp>.csv
│   └── extracted_logs/
```

---

## 🔚 Deliverables

- ✅ Script file: `remote_log_analyzer.sh`
- ✅ Reports: `remote_report.txt`, `remote_report.csv`
- ✅ This README
- ✅ All pushed to GitHub under `week3-summary` branch

---

## 🔗 Project Repository

You can find the full source code and updates here:  
👉 [GitHub Repository](https://github.com/Avichai98/linux-devops-course/edit/main/week3)
