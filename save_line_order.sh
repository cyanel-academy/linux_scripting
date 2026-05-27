#!/bin/sh
if [ $# -ne 3 ]; then
	echo "error wrong number of parameters" | tee -a err.log
	exit 1
fi

name=$1
price=$2
file_name=$3

if [ ! -f "file_name" ]; then
	echo "Error: '$file_name' does not exist" | tee -a err.log
	exit 1
fi
	
if ! echo "$price" | grep -q "^[0-9]\+$"; then
	echo "Error: Price must be an integer" | tee -a err.log
	exit 1
fi

if echo "$(printf "%-20s|%.2f" "$(echo "$name" | tr '[:lower:]' '[:upper:]')" "$price")">> "$file_name"; then
	exit 0
else 
	echo "Error: Could not write to fifle" >> err.log
	exit1
fi



