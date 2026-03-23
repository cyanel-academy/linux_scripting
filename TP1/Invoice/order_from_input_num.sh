#!/bin/sh

num_input=$1
invoice_num_file=$2
filename=invoice_$invoice_num_file.txt

printf "Enter product %d name: " $num_input
# read input value
read product
printf "Enter product %s's price: " $product
read price

./save_line_order_invoice.sh -n $product -p $price -f $filename

exit 0
