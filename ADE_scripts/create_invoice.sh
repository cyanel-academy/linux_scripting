#!/bin/sh

invoice_number=""

if [ $# -gt 0 ]; then # tant qu'il y a des arguments
	while [ $# -gt 0 ]; do    
        case "$1" in
	    	-f)
	    	invoice_number="$2"
	    	shift 2
	    	;;
	    	*) # all other cases
	    	echo "Invalid option \"$1\" !";
	    	echo "Invalid option" > err.log
	    	exit 1
	    	;;
	    esac
    done

else
    echo "What is the invoice number ?"
    read invoice_number
fi

file_output="invoice_$invoice_number.txt"

continue="1"
cpt=1

total_price=0

while [ "$continue" = "1" ]; do

    echo "\nEnter product $cpt name : "
    read product_name
    echo "\nEnter product $product_name's price : "
    read price

    echo "\n\ncontinue ? (yes/no) :"
    read continue_value

    product_category=$(./get_category_of.sh $product_name)

    product_name_maj=$(echo "$product_name" | tr '[:lower:]' '[:upper:]')

    line=$(printf  "%-15s     (%s)       |%10s\n" $product_name_maj $product_category $price)
    echo $line >> $file_output

    total_price=$(echo "$total_price + $price" | bc)

    case $continue_value in
        "y"|"yes")
        continue="1"
        ;;
        "n"|"no")
        continue="0"
        ;;
    esac

    cpt=$((cpt+1))

done


echo "-------------------------------------------" >> $file_output
last_line=$(printf  "%-15s            |%10s\n" "Total" $total_price)
echo $last_line >> $file_output



################################ A FINIR AJOUTER LE TOTAL

echo "\n\nYour order is saved in the file : $file_output"
echo "\n\nThis is the details :\n\n"
cat "$file_output"

exit 0