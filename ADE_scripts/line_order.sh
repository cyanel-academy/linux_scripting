#!/bin/sh

name=$1
price=$2
name_maj=$(echo "$name" | tr '[:lower:]' '[:upper:]')

price_adjusted=$(printf "%d.00" $price)

printf  "%-15s	|	%10s\n" $name_maj $price_adjusted

exit 0
