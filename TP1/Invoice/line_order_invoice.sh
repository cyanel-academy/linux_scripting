#!/bin/sh

name=$1
category=$2
price=$3

#category=$(./get_category_of.sh $name)

#puts the name in uppercase
name_cap=$(echo "$name" | tr '[:lower:]' '[:upper:]') 

printf "%-15s\t(%s)\t|%10.2f\n" "$name_cap" "$category" "$price"

exit 0
