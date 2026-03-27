 #!/bin/sh

echo "$1 $2" >> "$3"

if [ $# -ne 3 ]; then
    echo "Wrong number of parameters. Usage: $0 [product] [price] [file]"
    echo "$(date) - Wrong number of parameters" >> err.log
    exit 1
fi

product="$1"
price="$2"
file="$3"

#Pour vérifier que le fichier existe
if [ ! -f "$file" ]; then
     echo "Error: This '$file' does not exist: $file" >> err.log
     exit 1
fi

echo "$price" | grep -Eq '^[0-9]+([.,][0-9]+)?$'
if [ $? -ne 0 ]; then
    echo "Error: second argument is not a valid number."
    echo "$(date) - Invalid price: $price" >>err.log
   exit 1
fi

echo "$product $price" >> "$file"

echo "Order inserted"
exit 0 
