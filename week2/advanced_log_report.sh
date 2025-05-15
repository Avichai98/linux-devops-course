#!/bin/bash

# Log Analysis Script
# -------------------
# This script scans .log files in a given directory for specific keywords
# (e.g., ERROR, WARNING), and generates a summary report in text and optionally CSV format.


# Color codes for output formatting
RED="\e[31m"
YELLOW="\e[33m"
PURPLE="\e[35m"
CYAN="\e[96m"
GREEN="\e[92m"
RESET="\e[0m"

# Function to validate input directory
function validation() {
    # Validate if the provided directory exists
    if [[ -z "$1" || ! -d "$1" ]]; then
        echo -e "${RED}Error: Please provide a valid directory.${RESET}"
        echo "Usage: $0 <directory>"
        print_help
        exit 1
    fi
}

# Function to parse command-line arguments
function parse_args() {
    local -n args_ref=$1 # Use nameref to access the passed-in array by reference
    CSV_OUTPUT=false
    KEYWORDS=()

    for ((i = 0; i < ${#args_ref[@]}; i++)); do
        case "${args_ref[$i]}" in
        --keywords)
            # Collect keywords until the next flag or end of input
            for ((j = i + 1; j < ${#args_ref[@]}; j++)); do
                if [[ "${args_ref[$j]}" == --* ]]; then break; fi
                if [[ "${args_ref[$j]}" == -* ]]; then
                    echo -e "${RED}Error: Invalid flags format. Use -- ${RESET}"
                    print_help
                    exit 1
                fi
                KEYWORDS+=("${args_ref[$j]}")
                ((i++))
            done
            ;;
        --csv)
            CSV_OUTPUT=true
            ;;
        --help)
            print_help
            exit 0
            ;;
        *)
            # If the argument starts with '--' and is unrecognized, show error
            if [[ "${args_ref[$i]}" == --* ]]; then
                echo -e "${RED}Error: Unrecognized option '${args_ref[$i]}'${RESET}"
                print_help
                exit 1
            fi
            ;;
        esac
    done
}

# Function to display help
function print_help() {
    # Shows usage instructions for the script
    echo -e "${GREEN}Usage: $0 <log_directory> [--keywords keyword1 keyword2 ...] [--csv] [--help]${RESET}"
    echo "  <log_directory>   Directory containing log files."
    echo "  --keywords        Specify keywords to search for (e.g., ERROR, WARNING)."
    echo "  --help            Show this help message."
    echo "  --csv             Generate CSV output."
}

# Function to generate the report
function generate_report() {
    local log_dir="$1"
    local csv_flag="$2"
    shift 2
    local keywords=("${@}") # Get all keywords passed after the log directory

    echo -e "${CYAN}Generating report for logs in directory: $log_dir${RESET}" | tee report.txt
    [[ "$csv_flag" == "true" ]] && echo "Log File,Keyword,Occurrences" >report.csv

    # Loop through all .log files in the directory and subdirectories using 'find'
    # 'find' ensures recursive search and '-type f' limits results to regular files only
    # 'read -r' prevents backslashes in filenames from being interpreted as escape characters
    find "$log_dir" -type f -name "*.log" | while read -r log_file; do
        echo -e "${PURPLE}Log File: $log_file${RESET}" | tee -a report.txt
        echo "| Keyword   | Occurrences |" | tee -a report.txt
        echo "|-----------|-------------|" | tee -a report.txt

        # Loop over each keyword
        for keyword in "${keywords[@]}"; do
            count=$(count_keywords "$log_file" "$keyword")
            printf "| %-9s | %-11s |\n" "$keyword" "$count" | tee -a report.txt
            [[ "$csv_flag" == "true" ]] && echo "$log_file,$keyword,$count" >>report.csv
        done
        echo | tee -a report.txt
    done
}

# Function to count keyword occurrences in a log file
function count_keywords() {
    local log_file="$1"
    local keyword="$2"

    # Count the number of the keyword
    grep -o "$keyword" "$log_file" | wc -l
}

# Main function that controls the script execution flow
function main() {
    start_time=$(date +%s.%N)

    # Validate the directory argument
    validation "$1"

    # Parse keywords if provided
    ARGS=("$@")
    parse_args ARGS

    # If no keywords were passed, set default keywords
    if [[ ${#KEYWORDS[@]} -eq 0 ]]; then
        KEYWORDS=("ERROR" "WARNING" "CRITICAL")
    fi

    # Generate the report for the provided directory and keywords
    generate_report "$1" "$CSV_OUTPUT" "${KEYWORDS[@]}"

    end_time=$(date +%s.%N)
    execution_time=$(echo "$end_time - $start_time" | bc)
    execution_time=$(printf "%.9f" "$execution_time")

    echo -e "${YELLOW}Total Execution Time: ${execution_time} seconds${RESET}" | tee -a report.txt

    echo -e "${GREEN}The report file is ready!${RESET}"
    [[ "$CSV_OUTPUT" == "true" ]] && echo -e "${GREEN}CSV output written to report.csv${RESET}"
}

# Call the main function with all script arguments
main "$@"
