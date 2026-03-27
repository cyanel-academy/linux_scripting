#!/bin/sh

name=$1
price=$2

name_maj=$(echo "$name"|tr '[:lower:]' '[:upper:]')
price_round=$(printf "%d.00" "$price")

printf "%-15s | %8s\n" "$name_maj" "$price_round"

exit 0
