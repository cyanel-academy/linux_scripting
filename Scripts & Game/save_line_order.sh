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
   
if ! [[ $price =~ ^[0-9]+([.]+[0-9]+)?$ ]]; then 	# chech if the price is a digit 
    printf "ERROR: %s is not a number!\n" "$price"
    exit 1

else
    # puts the order details in the given filename (creates the dile if not existing)
    ./line_order.sh "$name" "$price" >> "$filename"
    printf "Order inserted!\n"

fi

exit 0
