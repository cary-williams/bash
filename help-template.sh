######################################
# Basic template for script usage    #
# Covers no arguments, -h or --help  #
# Put in start of bash script.
######################################

USAGE="$(basename "$0") [-h] <args> "
DESCRIPTION="Stick a description here"

if [ $# -eq 0 ] || [ $1 == "-h" ] || [ $1 == "--help" ]
then
    echo "Usage: $USAGE"
    echo ""
    echo "$DESCRIPTION\nadd anything else here"
    exit 0
fi


######################################
# Help Function                      #
# Add or remove any additional args  #
######################################
Help()
{
   # Display Help
   echo "Put a description of the functions here"
   echo ""
   echo "Syntax: scriptName [-g|h|v|V]"
   echo "options:"
   echo "g     Print the GPL license notification."
   echo "h     Print this Help."
   echo "v     Verbose mode."
   echo "V     Print software version and exit."
   echo ""
}

while getopts ":h" option; do
   case $option in
      h) # display Help
         Help
         exit;;
     \?) # incorrect option
         echo "Error: Invalid option"
         exit;;
   esac
done
