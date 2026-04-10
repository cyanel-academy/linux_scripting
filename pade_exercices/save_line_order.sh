#!/bin/bash

if [ $# -ne 3 ]; then
    echo "ERROR: Usage: ./save_line_order.sh [name] [price] [file_name]"
    exit 1
fi

name=$1
price=$2
filename=$3

# si le fichier existe (if -f)
if [ -f "$filename" ]; then
    echo "  ajout d'une nouvelle ligne dans $filename."
else
    echo "  création du fichier $filename."
fi

# '>>' pour ajter à la fin du fichier
./line_order.sh "$name" "$price" >> "$filename"

# verifions 0=ok, 1=ko
if [ $? -eq 0 ]; then
    echo "Order inserted successfully!"
    exit 0
else
    echo "An error occurred during save."
    exit 1
fi