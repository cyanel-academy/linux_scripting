#!/bin/bash

# 1. Ta fonction (réutilisée)
read_input() {
    local prompt="$1"
    local response
    read -p "$prompt" response
    echo "$response"
}

# 2. Initialisation (tes variables)
invoice_number=""
total=0

# Gestion du flag -f
if [ "$1" == "-f" ] && [ -n "$2" ]; then
    invoice_number=$2
else
    invoice_number=$(read_input "What is the invoice number? ")
fi

filename="invoice_${invoice_number}.txt"
> "$filename" # Vide le fichier s'il existait déjà

# 3. La Boucle (LOOP)
continue_order="y"
while [ "$continue_order" == "y" ]; do
    
    name=$(read_input "Enter product name: ")
    price_raw=$(read_input "Enter product $name's price: ")
    
    # Nettoyage du prix (remplace virgule par point pour bc)
    price=$(echo "$price_raw" | tr ',' '.')

    # RÉUTILISATION PRACTICE 6 : On appelle ton script de catégorie
    category=$(./get_category_of.sh "$name")
    
    # Préparation du nom : "PIANO (percussion)"
    display_name="$(echo $name | tr '[:lower:]' '[:upper:]') ($category)"

    # RÉUTILISATION LOGIQUE PRACTICE 2 : On formate et on écrit dans le fichier
    # On utilise printf pour l'alignement parfait
    printf "%-30s | %10.2f\n" "$display_name" "$price" >> "$filename"

    # Calcul du total avec 'bc' (pour gérer les décimales)
    total=$(echo "$total + $price" | bc)

    continue_order=$(read_input "continue? (yes/no): ")
    # On s'assure que si l'utilisateur tape 'y' ou 'yes', ça continue
    [[ "$continue_order" =~ ^[yY] ]] && continue_order="y" || continue_order="n"
done

# 4. Pied de facture
echo "------------------------------------------------" >> "$filename"
printf "%-30s | %10.2f\n" "Total" "$total" >> "$filename"

# 5. Résultat final
echo "Your order is saved in the file: $filename"
echo "This is the details:"
cat "$filename"