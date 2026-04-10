#!/bin/bash

UNDERLINE=$'\e[4m'
RESET=$'\e[0m'

#printf "Enter a user name: "
# read input value
read -p "${UNDERLINE}Enter a user name:${RESET} " input_user_name

#puts the name in uppercase
output_user_name=$(echo "$input_user_name" | tr '[:lower:]' '[:upper:]') 

echo $output_user_name

exit 0
