#!/bin/sh

#verification nombre d'arguments
if [ $# -ne 3 ]
then
    echo "Wrong number of parameters. Usage: ./save_line_order.sh [product] [price] [file]"
    exit 1
fi

name=$1
price=$2
file=$3

#  le prix est un nombre ?
echo "$price" | grep -Eq '^[0-9]+([.,][0-9]+)?$'
if [ $? -ne 0 ]
then
    echo "Error: price must be a number"
    exit 1
fi

# ecriture dans le fichier
echo "$name $price" >> "$file"

# commande réussie ?
if [ $? -ne 0 ]
then
    echo "Error: cannot write to file"
    exit 1
fi

echo "Order inserted"
exit 0
