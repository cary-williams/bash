#!/bin/bash

###################################
# Creates a CSR file              #
# used to generate an SSL         #
# certificate                     #
###################################

read -p "Enter domain: " TLD 
read -p "City: " city
read -p "State: " state
read -p "Organization Name: " org
read -p "CN " cn 

#replace . in TLD with _ to have more readable filename
newTLD="${TLD//./_}"

#openssl command to generate CSR
openssl req -new -newkey rsa:2048 -nodes -out $newTLD.csr -keyout $newTLD.key -subj "/C=US/ST=$state/L=$city/O=$org/CN=$cn"