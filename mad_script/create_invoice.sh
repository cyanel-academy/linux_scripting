#!/bin/sh
export LC_ALL=C
ask() {
     local message="$1"
     read -p "$message" response
     echo "$response"
}

get_category() {
     local instrument="$1"
   
     ./get_category_of.sh "$instrument"
}

if [ "$1" = "-f" ] && [ -n "$2" ]; then
     invoice_number="$2"
else
     invoice_number=$(ask "What is the invoice number? ")
fi

invoice_file="invoice_${invoice_number}.txt"
> "$invoice_file"

echo "Creating invoice number: $invoice_number"
echo ""

total=0
count=1
continue="yes"

while [ "$continue" = "yes" ] || [ "$continue" = "y" ]; do

      product=$(ask "Enter product $count name: ")
      price=$(ask "Enter product $product's price: ")

      price=$(printf "%.2f" "$price")
 
      category=$(get_category "$product")

      printf "%-10s (%-10s) | %10s\n" "$(echo "$product" | tr '[:lower:]' '[:upper:]')" "$category" "$price" >> "$invoice_file"
  
      total=$(echo "$total + $price" | bc)

      continue=$(ask "continue? (yes/no): ")

      count=$((count + 1))
      echo ""
done


echo "-----------------" >> "$invoice_file"
printf "%-23s | %10.2f\n" "Total" "$total" >> "$invoice_file"

echo ""
echo "Your order is saved in the file: $invoice_file"
echo ""
echo "This is the details:"
cat "$invoice_file"
