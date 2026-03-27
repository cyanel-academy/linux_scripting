#!bin/sh

read -p "Type the product name..." pname

read -p "Type the price of the product..." price

read -p "Name the file where the informations will be saved (Ex: stock.txt)..." file


echo "$pname $price" >> "$file"
printf "%-20s|%.2f in the file: %s\n" "$(echo "$pname" | tr '[:lower:]' '[:upper:]')" "$price" "$file"
