# Bash Script: Advanced Automated Log Report Generator

This Bash script processes `.log` files in a given directory (recursively), searches for specified keywords (e.g., ERROR, WARNING, CRITICAL), and generates a human-readable report and optionally a CSV file.

## 🧠 Task Description

> Create a Bash script that scans all `.log` files in a specified directory, recursively, and generates a report showing the number of times specific keywords (e.g., `ERROR`, `WARNING`, `CRITICAL`) appear in each file. The report should be saved as a text file (`report.txt`) and optionally as a CSV file if requested via a flag.

## 🔧 Features

- Recursive directory scanning using `find`
- Supports custom keywords via arguments
- Outputs colored report to terminal and saves to `report.txt`
- Optional CSV export via `--csv` flag
- Optional `--help` flag that explains usage instructions. 
- Execution time tracking

## 🚀 Usage

```bash
./log_report.sh <log_directory> [--keywords keyword1 keyword2 ...] [--csv]
```

### Examples:

```bash
# Use default keywords
./log_report.sh logs

# Custom keywords
./log_report.sh logs --keywords ERROR timeout crash

# Custom keywords + CSV export
./log_report.sh logs --keywords ERROR WARNING --csv
```

## 📂 Output

- `report.txt`
- `report.csv`: CSV version (if `--csv` used)

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

- Accept a log directory as an input parameter. 

- Support a `--keywords` flag allowing multiple keywords (e.g., ERROR, WARN, CRITICAL). 

- For each log file in the directory: 
- Count occurrences of each keyword. 
- Format the output as a readable table. 

- Generate a `report.txt` file summarizing results. 

- Support a `--help` flag that explains usage instructions. 

- Calculate and display the total script execution time at the end of the report. 

- Structure the script using functions (e.g., `count_keywords()`, `generate_report()`, `print_help()`). 

- Include input validation and clear error messages. 

- Write clear comments to explain the logic. 

- Ensure the report is clean and professional, optionally export as CSV. 

## 🔗 Project Repository

You can find the full source code and updates here:  
👉 [GitHub Repository](https://github.com/Avichai98/linux-devops-course/edit/main/week2)
