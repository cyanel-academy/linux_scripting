#!/bin/sh

read_input() {
    local message=$1
    read -p "$message" response
    echo "$response"
}
# Vérification du nombre d'arguments
if [ "$#" -ne 2 ] || [ "$1" != "-f" ]; then
    echo "Usage: $0 -f <invoice_number>"
    exit 1
fi

# Récupération du numéro de la facture
invoice_number="$2"
invoice_file="invoice_$invoice_number.txt"

# Demander le numéro de la facture si l'argument -f n'est pas passé
echo "Creating invoice #$invoice_number..."

# Initialiser la facture dans le fichier
echo "Invoice #$invoice_number" > "$invoice_file"
echo "------------------------------------" >> "$invoice_file"

# Initialiser le total
total=0

# Boucle do-while pour ajouter des produits
continue_choice="y"

# Exécution au moins une fois
while true; do
    # Demander le nom du produit
    pname=$(read_input "Enter product name: ")

    # Demander le prix du produit
    price=$(read_input "Enter product $pname's price: ")

    # Vérifier si le prix est un nombre valide
    if ! echo "$price" | grep -qE '^[0-9]+(\.[0-9]+)?$'; then
        echo "Erreur : Le prix doit être un nombre valide."
        continue
    fi

    # Utiliser le script précédent pour obtenir la catégorie de l'instrument
    category=$(./get_category_of.sh "$pname")

    # Ajouter le produit à la facture avec le formatage demandé
    printf "%-20s|%-15s|%.2f\n" "$(echo "$pname" | tr '[:lower:]' '[:upper:]')" "$category" "$price" >> "$invoice_file"

    # Mettre à jour le total
    total=$(echo "$total + $price" | bc)

    # Demander si l'utilisateur veut ajouter un autre produit
    continue_choice=$(read_input "Continue? (yes/no): ")

    # Si l'utilisateur répond "no", on sort de la boucle
    if [ "$continue_choice" != "yes" ] && [ "$continue_choice" != "y" ]; then
        break
    fi
done

# Ajouter le total à la facture avec un formatage
echo "------------------------------------" >> "$invoice_file"
printf "%-20s|%-15s|%.2f\n" "Total" " " "$total" >> "$invoice_file"

# Afficher un message de confirmation
echo "Your order is saved in the file: $invoice_file"
