#!/bin/bash
if [ $# -ne 3 ]; then 
echo "wrong numberof parameters. usage ./save_line_order [product] [price] [file]"
exit 1
fi
nom=$(echo "$1" | tr '[:lower:]' '[:upper:]')
prix=$2
nom_fichier=$3
if printf "%-15s |  %10.2f\n" "$nom" "$prix">> "$nom_fichier";then
exit 0
else
echo "An error occurred while saving the order"
exit 1
fi


