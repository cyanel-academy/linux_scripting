#!/bin/bash

#printf "Enter a user name: "
# read input value
read -p "Enter a user name: " input_user_name

#puts the name in uppercase
output_user_name=$(echo "$input_user_name" | tr '[:lower:]' '[:upper:]') 

echo $output_user_name

exit 0
