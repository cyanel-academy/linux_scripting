#!/bin/bash

#on réutilise la fonction
read_input() {
    local prompt="$1"
    local response
    read -p "$prompt" response
    echo "$response"
}

#Initialisation variables
invoice_number=""
total=0

# flag -f
if [ "$1" == "-f" ] && [ -n "$2" ]; then
    invoice_number=$2
else
    invoice_number=$(read_input "What is the invoice number? ")
fi

filename="invoice_${invoice_number}.txt"
> "$filename" # Vide le fichier if exist

# LOOP
continue_order="y"
while [ "$continue_order" == "y" ]; do
    
    name=$(read_input "Enter product name: ")
    price_raw=$(read_input "Enter product $name's price: ")
    
    # remplace virgule par point pour bc
    price=$(echo "$price_raw" | tr ',' '.')

    # PRACT 6 : get category
    category=$(./get_category_of.sh "$name")
    
    # nom : "PIANO (percussion)"
    display_name="$(echo $name | tr '[:lower:]' '[:upper:]') ($category)"

    # PRACT 2 : formater et on écrit dans le fichier
    printf "%-30s | %10.2f\n" "$display_name" "$price" >> "$filename"

    # Calcul du total 
    total=$(echo "$total + $price" | bc)

    continue_order=$(read_input "continue? (yes/no): ")
    # tape 'y' ou 'yes', pour qu'ça continue
    [[ "$continue_order" =~ ^[yY] ]] && continue_order="y" || continue_order="n"
done

# 4. fin facture
echo "------------------------------------------------" >> "$filename"
printf "%-30s | %10.2f\n" "Total" "$total" >> "$filename"

# 5. Résultat final
echo "Your order is saved in the file: $filename"
echo "This is the details:"
cat "$filename"