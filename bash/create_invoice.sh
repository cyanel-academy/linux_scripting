#!/bin/sh 

ask_question() {
echo "$1"
read answer
answer=$(echo "$answer" | tr -d '\r')
}


if [ "$1" = "-f" ]; then
 invoice_num="$2"
else
 ask_question "What is the invoice number?"
 invoice_num="$answer"
fi

file_name="invoice_${invoice_num}.txt"
rm -f "$file_name"
touch "$file_name"

count=1
total=0
keep_going="yes"


while [ "$keep_going" = "yes" ] || [ "$keep_going" = "y" ]; do
 ask_question "Enter product $count name:"
 name="$answer"

 ask_question "Enter product ${name}'s price:"
 price="$answer"
 price_format=$(printf "%.2f" "$price")

 category=$(./get_category_of.sh "$name")

 name_maj=$(echo "$name" | tr '[:lower:]' '[:upper:]')
 printf "%-10s %-15s | %9s\n"  "$name_maj" "($category)"  "$price_format" >> "$file_name"


 total=$(awk "BEGIN {print $total + $price}")
 total_format=$(printf "%.2f" "$total")

 ask_question "continue? (yes/no)"
 keep_going="$answer"
 count=$((count + 1))

done

echo "Your order is saved in the file: $file_name"
echo "This is the details:"
cat "$file_name"
echo "------------------------"
printf "%-26s | %9s\n" "Total" "$total_format"

