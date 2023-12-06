#!/bin/bash

################################################################################
# Description:                                                                 #
#   This script performs WHOIS lookups for a list of IP addresses from a file. #
#   It prompts the user to enter a search term, then checks the WHOIS output   #
#   for each IP. If the specified term is not found in the WHOIS output, the   #
#   IP address is written to a separate file. Useful for verifying ownership   #
#   of a list of IP addresses                                                  #
#                                                                              #
# Requirements:                                                                #
#   - 'whois' command must be installed on the system.                         #
#   - Input file 'ip_list.txt' containing a list of IP addresses (one per line)#
#                                                                              #
# Usage:                                                                       #
#   1. Ensure 'whois' is installed on the system.                              #
#   2. Place the list of IP addresses in 'ip_list.txt' file.                   #
#   3. The script will create a file 'non_matching_ips.txt' with IPs           #
#      not associated with the specified search term in the WHOIS output.      #
################################################################################


# Check if whois command exists
if ! command -v whois &> /dev/null; then
    echo "Error: 'whois' command not found. Please install whois to proceed."
    exit 1
fi

# Term to search for in WHOIS output
read -p "Enter the term to search for in WHOIS output: " search_term

# Input file concataining IP addresses
input_file="ip-list.txt"

# Output file for IPs not associated with Akamai
output_file="ip-output.txt"

# Loop through each IP in the input file
while IFS= read -r ip || [[ -n "$ip" ]]; do
    # Perform WHOIS lookup for the IP

    whois_output=$(whois "$ip")
    
    # Check if WHOIS output contains the search term
    if ! grep -iq "$search_term" <<< "$whois_output"; then
        # If term is not found, write IP to the output file
        echo "$ip" >> "$output_file"
    fi
done < "$input_file"
