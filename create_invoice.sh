#!/bin/sh
input() {
	echo "$1" >&2
	read response
	echo "$response"
}

if [ "$1" = "-f" ] && [ ! -z "$2" ]; then
	invoice_num=$2
else
	invoice_num=$(input "what is the invoice number")
fi

file_name="invoice_${invoice_num}.txt"
> "$file_name" 
total=0
cont="y"
count=1

while [ "$cont" = "y" ] || [ "$cont" = "yes" ]; do
	product=$(input "enter product $count name")
	price=$(input "enter product ${product} price:")

	category=$(./get_category_of.sh "$product")

	line=$(printf "%-10s (%-12s) | %10.2f" "$(echo "$product" | tr ' [:lower:] ' ' [:upper:] ')" "$category" "$price")
	echo "$line" >> "$file_name"

	total=$(echo "$total + $price" | bc)

	cont=$(input "continue? (yes/no):")
	count=$((count+1))
done

echo"-----------------------------------------" >> "$file_name" 
printf "%-25s | %10.2f\n" "Total" "$total" >> "$file_name"

echo "your oder is saved in the file: $file_name"
echo "this isthe details:"
cat "$file_name"
