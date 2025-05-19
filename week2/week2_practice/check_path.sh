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

