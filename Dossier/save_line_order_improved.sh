#!/bin/sh

# Pour vérifier le nombre d'arguments
if [ "$#" -ne 3 ]; then
  echo "Error : Wrong number of parameters" >> err.log
  echo "Please follow this script: $0 <product_name> <price> <file_name>" >> err.log
  exit 1
fi

pname="$1"
price="$2"
file="$3"

# Pour vérifier si le fichier existe
if [ ! -f "$file" ]; then
  echo "Error : The file '$file' doesn't exist." >> err.log
  exit 1
fi

# Pour vérifier si le prix est un entier
if ! echo "$price" | grep -qE '^[0-9]+$'; then
  echo "Error : The price '$price' is not an integer." >> err.log
  exit 1
fi

echo "$pname $price" >> "$file"
printf "%-20s|%.2f in the file: %s\n" "$(echo "$pname" | tr '[:lower:]' '[:upper:]')" "$price" "$file"

exit 0

