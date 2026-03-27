#!/bin/bash

# initialisation of the different variables
name=""
price=""
filename=""

# program waits for a value for n, p and f (: means it is waiting for an argument)
# OPTARG is the value given after the option
while getopts "n:p:f:" opt; do
	case "$opt" in
		n) name="$OPTARG" ;;
		p) price="$OPTARG" ;;
		f) filename="$OPTARG" ;;
		*)
			printf "ERROR: Synopsis must be save_line_order_case.sh -n [name] -p [price] -f [filename]\n"
			exit 1
			;;
	esac
done

# initialisation of the category variable after getting the name with getops
category=$(./get_category_of.sh $name)
   
if ! [[ $price =~ ^[0-9]+([.]+[0-9]+)?$ ]]; then 	# chech if the price is a digit 
    printf "ERROR: %s is not a number!\n" "$price"
    exit 1

else
    # puts the order details in the given filename (creates the file if not existing)
    ./line_order_invoice.sh "$name" "$category" "$price" >> "$filename"
    printf "Order inserted!\n"

fi

exit 0
