#!/bin/bash

export LC_NUMERIC=C

# initialisation of the variables
invoice_num=""
input_num=1
continue=1
total=0

##########################
# GET THE INVOICE NUMBER #
##########################

if [ $# -eq 0 ]; then 	# chech if no args have been given
    printf "What is the invoice number? "
	# read input value
	read invoice_num
	printf "\n"

else
    # program waits for a value for f (: means it is waiting for an argument)
	# OPTARG is the value given after the option
	while getopts "f:" opt; do
		case "$opt" in
			f) invoice_num="$OPTARG" ;;
			*) printf "ERROR: Synopsis must be create_invoice.sh -f [invoice_number]\n" exit 1 ;;
		esac
	done
fi

while [ $continue -eq 1 ]; do
	./order_from_input_num.sh $input_num $invoice_num
	printf "\n"
	
	printf "continue? (yes/no): "
	read continue_string
	case "$continue_string" in
		yes|y) continue=1 ;;
		no|n) continue=0 ;;
		*) printf "unvalid input -> continue\n" ;;
	esac
	((input_num+=1))
	printf "\n"
done

printf "Your order is saved in the file: invoice_%d.txt\n\n" $invoice_num

printf "This is the details:\n\n"

# we get all the fields from the file
# we use the 
while read product category separator price; do
	#echo "DEBUG : product: "$product" category: "$category" separator: "$separator" price: "$price""
	printf "%-15s\t%s\t|%10.2f\n" "$product" "$category" "$price"
	total=$(echo "$total + $price" | bc)
done < invoice_$invoice_num.txt
echo "-------------------------------------------"
printf "Total\t\t\t\t|%10.2f\n" "$total"



