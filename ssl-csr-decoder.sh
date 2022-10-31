#!/bin/bash

########################################
# Decodes an existing SSL CSR          #
#                                      #
# Usage:                               #
# ssl-csr-decoder.sh /path/to/file.csr #
########################################

openssl req -in $1 -noout -text