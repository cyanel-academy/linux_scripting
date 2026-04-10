#!/bin/bash

# Vérifie syntaxe
if [ $# -ne 2 ]; then
    echo "Usage: line_order.sh [name] [price]"
    exit 1
fi

name=$1
input_price=$2

#gérer la virgule
price=$(echo "$input_price" | tr ',' '.')

# maj
name_upper=$(echo "$name" | tr '[:lower:]' '[:upper:]')

# a retnir pour maitiser l'affichage :
# %-25s  : Texte aligné à gauche sur 25 caractères
# %8.2f  : Nombre aligné à droite avec 2 décimales après le point
printf "%-25s | %8.2f\n" "$name_upper" "$price"