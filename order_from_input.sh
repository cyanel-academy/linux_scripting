#!/bin/sh
echo "What is the product name? (type a value)"
read name

echo "What is  the price. (type a value)"
read price
echo " "
printf "%-20s|%.2f\n" "$(echo "$name" | tr '[:lower:]' '[:upper:]')" "$price"

