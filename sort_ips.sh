#!/bin/bash

################################################################################
# Script Name: sort_ips.sh
# Description: This script reads a list of IP addresses from an input file,
#              removes any blank lines, sorts the IPs in numerical order, and
#              removes the subnet mask if provided.
#
# Author:      Cary Williams
# Date:        29 Feb 2024
# Version:     1.0
#
# Change History:
# - 29 Feb 2024 Cary Williams: initial
################################################################################

# Check if the input file is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

input_file="$1"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' not found."
    exit 1
fi

# Remove empty lines and sort IPs
sort_ips() {
    # Remove empty lines using grep
    # Sort IPs and remove subnet masks using awk
    grep -v '^$' "$input_file" | awk -F'[ /]' '{for(i=1;i<=NF;i++){if($i~/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/){print $i}}}' | sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4
}

# Call function to sort IPs and remove subnet masks
sorted_ips=$(sort_ips)

# Overwrite the input file with sorted IPs without subnet masks
echo "$sorted_ips" > "$input_file"

echo "Sorted IPs without subnet masks have been written to '$input_file'."

# Count the total number of IPs
total_ips=$(echo "$sorted_ips" | wc -l)
echo "Total number of IPs: $total_ips"
