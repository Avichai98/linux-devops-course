# 🧪 Week 2 – Daily Practice Tasks

This repository contains solutions to the **Week 2 DevOps daily practice tasks**. Each task is implemented in a dedicated Bash script located in the `week2_practice` folder.

---

## ✅ Task 1: Hello DevOps Script

A simple Bash script that prints `"Hello DevOps"` to the console.

**Filename:** `hello_devops.sh`

```bash
#!/bin/bash

echo "Hello DevOps"
```

---

## ✅ Task 2: File & Directory Checker

Checks if the given argument is a file, a directory, or does not exist.

**Filename:** `file_checker.sh`

```bash
#!/bin/bash

# Check if an argument was provided
if [[ -z "$1" ]]; then
    echo "Usage: $0 <filename_or_directory>"
    exit 1
fi

# Check if the argument is a file
if [[ -f "$1" ]]; then
    echo "It's a file"

# Check if the argument is a directory
elif [[ -d "$1" ]]; then
    echo "It's a directory"

# If neither, it probably doesn't exist
else
    echo "The file or directory does not exist"
fi
```

---

## ✅ Task 3: List Files with Sizes

Lists all files in the current directory and prints their sizes in KB in a formatted table.

**Filename:** `list_files.sh`

```bash
#!/bin/bash

# Print table headers
printf "%-30s %10s\n" "Filename" "Size (KB)"
printf "%-30s %10s\n" "--------" "----------"

# Loop through all items in the current directory
for file in *; do
    # Check if it's a regular file
    if [[ -f "${file}" ]]; then
        # Get file size in kilobytes (only the number using cut)
        size_kb=$(du -k "${file}" | cut -f1)
        # Print file name and size, aligned nicely in a table
        printf "%-30s %10s\n" "$file" "${size_kb}"
    fi
done
```

---

## ✅ Task 4: Search for ERROR Logs

Searches for the word `ERROR` in a log file and counts its occurrences.

**Filename:** `search_error.sh`

```bash
#!/bin/bash

# Print all lines containing the word "ERROR" with line numbers
grep -in "ERROR" "$1"

# Count how many times the word "ERROR" appears in total (even multiple times in the same line)
count=$(grep -io "ERROR" "$1" | wc -l)

# Print the total number of appearances
echo "Total appearance of 'ERROR': $count"
```

---

## ✅ Task 5: AWK Column Extractor

Prints the second column of a CSV file using `awk`.

**Filename:** `awk_column.sh`

```bash
#!/bin/bash

# -F',' sets the field separator as a comma (,), and {print $2} prints the second column from each line of the file provided as the first argument ("$1")
awk -F',' '{print $2}' "$1"
```

---

## 📁 Folder Structure

```
week2_practice/
├── hello_devops.sh
├── file_checker.sh
├── list_files.sh
├── search_error.sh
├── awk_column.sh
```

---

Created by Avichai Shchori
