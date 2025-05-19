#!/bin/bash

# Print all lines containing the word "ERROR" with line numbers
grep -in "ERROR" "$1"

# Count how many times the word "ERROR" appears in total (even multiple times in the same line)
count=$(grep -io "ERROR" "$1" | wc -l)

# Print the total number of appearances
echo "Total appearance of 'ERROR': $count"

