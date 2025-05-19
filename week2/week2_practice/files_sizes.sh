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
                        
