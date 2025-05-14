# Bash Script: Log Keyword Counter & Report Generator

This Bash script processes `.log` files in a given directory (recursively), searches for specified keywords (e.g., ERROR, WARNING, CRITICAL), and generates a human-readable report and optionally a CSV file.

## 🧠 Task Description

> Create a Bash script that scans all `.log` files in a specified directory, recursively, and generates a report showing the number of times specific keywords (e.g., `ERROR`, `WARNING`, `CRITICAL`) appear in each file. The report should be saved as a text file (`report.txt`) and optionally as a CSV file if requested via a flag.

## 🔧 Features

- Recursive directory scanning using `find`
- Supports custom keywords via arguments
- Outputs colored report to terminal and saves to `report.txt`
- Optional CSV export via `--csv` flag
- Execution time tracking

## 🚀 Usage

```bash
./log_report.sh <log_directory> [--keywords keyword1 keyword2 ...]
```

### Examples:

```bash
# Use default keywords
./log_report.sh logs

# Custom keywords
./log_report.sh logs --keywords ERROR timeout crash
```

## 📂 Output

- `report.txt`: Human-readable summary

## 📁 File Structure Example

```
project/
├── log_report.sh
├── README.md
├── logs/
│   ├── app1.log
│   ├── subdir1/
│   │   └── app3.log
```

## 🧪 Requirements

- Bash
- Standard Unix tools: `grep`, `wc`, `bc`, `find`

Created by Avichai Shchori
