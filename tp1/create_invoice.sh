#!/bin/bash

ask() {
    read -p "$1" user_input
    echo "$user_input"
}

get_category() {
    case $(echo "$1" | tr '[:upper:]' '[:lower:]') in
        guitar|ukulele|violin|bass|harp) echo "strings" ;;
        piano|drum|xylophone|marimba) echo "percussion" ;;
        flute|oboe|clarinet|saxophone|trumpet) echo "others" ;;
        *) echo "unknown" ;;
    esac
}

invoice_number=""
while getopts "f:" opt; do
    case $opt in
        f) invoice_number=$OPTARG ;;
    esac
done

if [ -z "$invoice_number" ]; then
    invoice_number=$(ask "What is the invoice number? ")
fi

output_file="invoice_${invoice_number}.txt"

reponse=8
product_count=0
names=()
prices=()

while [ "$reponse" != "n" ] && [ "$reponse" != "no" ]; do
    product_count=$((product_count + 1))
    name=$(ask "Enter product $product_count name: ")
    price=$(ask "Enter product ${name}'s price: ")
    names+=("$name")
    prices+=("$price")
    reponse=$(ask "continue? (yes/no): ")
done

total=0
invoice_lines=""

for i in "${!names[@]}"; do
    name="${names[$i]}"
    price="${prices[$i]}"
    category=$(get_category "$name")
    upper_name=$(echo "$name" | tr '[:lower:]' '[:upper:]')
    line=$(printf "%-10s(%-13s) | %9.2f\n" "$upper_name" "$category" "$price")
    invoice_lines+="$line\n"
    total=$(echo "scale=2; $total + $price" | bc)
done

{
    printf "%b" "$invoice_lines"
    printf "%s\n" "--------------------------------------"
    printf "%-26s| %9.2f\n" "Total" "$total"
} > "$output_file"

echo ""
echo "Your order is saved in the file: $output_file"
echo ""
echo "This is the details:"
echo ""
cat "$output_file"