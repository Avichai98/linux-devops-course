#!/bin/bash


# -F',' sets the field separator as a comma (,), and {print $2} prints the second column from each line of the file provided as the first argument ("$1")
awk -F',' '{print $2}' "$1"
