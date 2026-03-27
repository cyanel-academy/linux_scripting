#!/bin/sh

echo "What is the product name, (type a value)"
name=$1
read name

echo "What is the price? (type a value)"
price=$2
read price

name_maj=$(echo "$name"|tr '[:lower:]' '[:upper:]')
price_round=$(printf "%d.00" "$price")

printf "%-15s | %8s\n" "$name_maj" "$price_round"

exit 0
