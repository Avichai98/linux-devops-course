#!/bin/bash

# =============================================
# Remote Log Analyzer via SSH
# =============================================
# This script connects to a remote VM using SSH key authentication, retrieves logs,
# supports recursive downloads (optional), analyzes keywords,
# extracts compressed logs (ZIP/TAR), and generates TXT & CSV reports.
# Optional email sending of report is supported.
#
# Usage:
# ./remote_log_analyzer.sh <user@host> <remote_log_directory> [--keywords WORD1 WORD2] [--email recipient@example.com] [--recursive|-r] [--help]
# =============================================

# Variables
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
REPORT_DIR="logs_report"
REPORT_TXT="$REPORT_DIR/remote_report_$TIMESTAMP.txt"
CSV_REPORT="$REPORT_DIR/remote_report_$TIMESTAMP.csv"
EXTRACT_DIR="$REPORT_DIR/extracted_logs"
EMAIL_RECIPIENT=""
KEYWORDS=("ERROR" "WARNING" "CRITICAL")
REMOTE_SERVER=""
REMOTE_LOG_DIR=""
RECURSIVE=false

# Colors for terminal output
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

# Validate input parameters
function validate_input() {
    if [[ -z "$REMOTE_SERVER" || -z "$REMOTE_LOG_DIR" ]]; then
        echo -e "${RED}Usage: $0 <user@host> <remote_log_directory> [--keywords WORD1 WORD2] [--email recipient@example.com] [--recursive|-r]${RESET}"
        exit 1
    fi
}

# Display help menu
function print_help() {
    echo -e "${GREEN}Usage: $0 <user@host> <remote_log_directory> [OPTIONS]${RESET}"
    echo -e "  --keywords WORD1 WORD2    Specify keywords to search for (default: ERROR WARNING CRITICAL)"
    echo -e "  --email recipient@example.com  Send report via email"
    echo -e "  --recursive, -r           Download logs recursively from nested directories"
    echo -e "  --help                    Show this help menu"
    exit 0
}

# Parse script arguments
function parse_args() {
    args=("$@")
    for ((i = 2; i < ${#args[@]}; i++)); do
        case "${args[$i]}" in
        --keywords)
            KEYWORDS=()
            for ((j = i + 1; j < ${#args[@]}; j++)); do
                [[ "${args[$j]}" == --* ]] && break
                KEYWORDS+=("${args[$j]}")
                ((i++))
            done
            ;;
        --email)
            EMAIL_RECIPIENT="${args[$i + 1]}"
            ((i++))
            ;;
        --recursive | -r)
            RECURSIVE=true
            ;;
        --help)
            print_help
            ;;
        *)
            echo -e "${RED}Error: Unrecognized option '${args[$i]}'${RESET}"
            print_help
            exit 1
            ;;
        esac
    done
}

# Download logs using scp or rsync depending on recursion flag
function download_logs() {
    mkdir -p "$REPORT_DIR"
    echo -e "${YELLOW}Downloading logs from $REMOTE_SERVER:$REMOTE_LOG_DIR ...${RESET}"

    if [ "$RECURSIVE" = true ]; then
        # Recursive download with scp -r
        scp -r "$REMOTE_SERVER:$REMOTE_LOG_DIR" "$REPORT_DIR/"
        if [[ $? -ne 0 ]]; then
            echo -e "${RED}Error: Failed to download logs recursively.${RESET}"
            exit 1
        fi
    else
        # Download logs from remote server without recursion (only files in the specified directory)
        # rsync: efficient file transfer and synchronization tool
        # -a: archive mode, preserves symbolic links, permissions, modification times
        # -v: verbose output, shows details of transfer
        # --no-recursive: disables recursive copying, only copies files in the given directory (no subdirectories)
        rsync -av --no-recursive "$REMOTE_SERVER:$REMOTE_LOG_DIR/" "$REPORT_DIR/"

        if [[ $? -ne 0 ]]; then
            echo -e "${RED}Error: Failed to download logs (non-recursive).${RESET}"
            exit 1
        fi
    fi
}

# Extract compressed logs (tar.gz and zip)
function extract_logs() {
    mkdir -p "$EXTRACT_DIR"
    echo -e "${CYAN}Checking for compressed log files to extract...${RESET}"

    # Extract tar.* files (tar, tar.gz, tar.bz2, tar.xz)
    find "$REPORT_DIR" -type f \( -iname "*.tar" -o -iname "*.tar.gz" -o -iname "*.tgz" -o -iname "*.tar.bz2" -o -iname "*.tar.xz" \) -print0 |
    while IFS= read -r -d '' tarfile; do
        target_dir="$EXTRACT_DIR/$(basename "${tarfile%.*.*}")"
        mkdir -p "$target_dir"
        echo "Extracting $tarfile to $target_dir ..."
        tar -xf "$tarfile" -C "$target_dir"
        if [[ $? -ne 0 ]]; then
            echo -e "${RED}Warning: Failed to extract $tarfile${RESET}"
        fi
    done

    # Extract zip files
    find "$REPORT_DIR" -type f -iname "*.zip" -print0 |
    while IFS= read -r -d '' zipfile; do
        target_dir="$EXTRACT_DIR/$(basename "${zipfile%.zip}")"
        mkdir -p "$target_dir"
        echo "Extracting $zipfile to $target_dir ..."
        unzip -qq -o "$zipfile" -d "$target_dir"
        if [[ $? -ne 0 ]]; then
            echo -e "${RED}Warning: Failed to extract $zipfile${RESET}"
        fi
    done
}

# Analyze log files for specified keywords
function analyze_logs() {
    echo -e "${CYAN}Analyzing log files for keywords: ${KEYWORDS[*]} ...${RESET}"

    echo -e "Remote Server: $REMOTE_SERVER\nAnalyzed Directory: $REMOTE_LOG_DIR\n" | tee "$REPORT_TXT"
    echo "File Name,Keyword,Count" >"$CSV_REPORT"

    # Find all .log files in report and extracted directories
    mapfile -t log_files < <(find "$REPORT_DIR" "$EXTRACT_DIR" -type f -name "*.log")

    if [ ${#log_files[@]} -eq 0 ]; then
        echo -e "${YELLOW}Warning: No log files found to analyze.${RESET}"
    fi

    for file in "${log_files[@]}"; do
        filename=$(basename "$file")
        echo -e "${GREEN}Scanning $file ...${RESET}"
        echo "| File Name | Keyword | Occurrences |" | tee -a "$REPORT_TXT"
        echo "|-----------|---------|-------------|" | tee -a "$REPORT_TXT"

        for keyword in "${KEYWORDS[@]}"; do
            count=$(grep -o "$keyword" "$file" | wc -l)
            echo "$filename,$keyword,$count" >>"$CSV_REPORT"
            printf "| %-9s | %-7s | %-11s |\n" "$filename" "$keyword" "$count" | tee -a "$REPORT_TXT"
        done
    done

    END_TIME=$(date +%s.%N)
    EXEC_TIME=$(echo "$END_TIME - $START_TIME" | bc)

    # Append execution time to TXT report
    echo -e "\nTotal Execution Time: $EXEC_TIME seconds" | tee -a "$REPORT_TXT"
    # Append execution time to CSV report as last line
    echo "Execution Time (seconds),,,${EXEC_TIME}" >>"$CSV_REPORT"
}

# Send report via email if recipient specified
function send_email() {
    if [[ -n "$EMAIL_RECIPIENT" ]]; then
        echo -e "${CYAN}Sending report to $EMAIL_RECIPIENT ...${RESET}"
        if command -v mail >/dev/null 2>&1; then
            cat "$REPORT_TXT" | mail -s "Remote Log Report from $REMOTE_SERVER" "$EMAIL_RECIPIENT"
        else
            echo -e "${RED}Error: mail command not found. Cannot send email.${RESET}"
        fi
    fi
}

# Measure execution time
START_TIME=$(date +%s.%N)

# Main
REMOTE_SERVER="$1"
REMOTE_LOG_DIR="$2"

validate_input
parse_args "$@"
download_logs
extract_logs
analyze_logs
send_email

#printf "${YELLOW}Total Execution Time: %.2f seconds${RESET}\n" "$EXEC_TIME"
