#!/bin/sh

name=$1
price=$2

#puts the name in uppercase
name_cap=$(echo "$name" | tr '[:lower:]' '[:upper:]') 

#printf "%s\t|%10s\n" "PRODUCT" "PRICE"
printf "%s\t|%10.2f\n" $name_cap $price

exit 0
