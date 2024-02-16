#!/bin/bash

################################################################################
# Script Name: whois.sh
# Description: This script reads a list of IP addresses from an input file,
#              performs a WHOIS lookup on each IP address, and filters out
#              IP addresses associated with specified domains. This allows to
#              quickly see if any of the IPs are not owned by a particular 
#              organization or ISP.
#
# Author:      Cary Williams
# Date:        16 Feb 2024
# Version:     1.0
#
# Change History:
# - 16 Feb 2024 Cary Williams: initial
################################################################################

# Usage: whois.sh -i <input_file> [-o <output_file>] [-e <exclude_string1,exclude_string2,...>]
# Flags:
#   -i <input_file>: Specify the input file containing a list of IP addresses.
#   -o <output_file>: Specify the output file where filtered IP addresses will be saved (optional).
#   -e <exclude_string1,exclude_string2,...>: Check whois to see if the results match any of these.
#                                             If not, the IP will be filtered out to the output file.
#                                             Strings should be separated by commas.

# Function to display usage information
usage() {
    echo "Usage: $0 -i <input_file> [-o <output_file>] [-e <exclude_string1,exclude_string2,...>]"
    exit 1
}

# Parse command line options
while getopts ":i:o:e:" opt; do
    case $opt in
        i) input_file="$OPTARG" ;;
        o) output_file="$OPTARG" ;;
        e) IFS=',' read -r -a exclude_strings <<< "$OPTARG" ;;
        \?) echo "Invalid option: -$OPTARG" >&2
            usage ;;
        :) echo "Option -$OPTARG requires an argument." >&2
            usage ;;
    esac
done

# Check if input file is provided
if [ -z "$input_file" ]; then
    echo "Input file is required."
    usage
fi

# Check if exclude strings are provided
if [ ${#exclude_strings[@]} -eq 0 ]; then
    echo "Exclude strings are required."
    usage
fi

# Loop through each line in the input file
while IFS= read -r ip_address; do
    # Perform WHOIS lookup and check if the result does not contain exclude strings
    excluded=false
    for exclude_string in "${exclude_strings[@]}"; do
        if whois "$ip_address" | grep -qiE "$exclude_string"; then
            excluded=true
            break
        fi
    done
    
    if ! $excluded; then
        if [ -z "$output_file" ]; then
            # If output file is not specified, print the IP address to stdout
            echo "$ip_address"
        else
            # If output file is specified, append the IP address to the output file
            echo "$ip_address" >> "$output_file"
        fi
    fi
done < "$input_file"