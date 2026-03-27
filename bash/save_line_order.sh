#!/bin/sh

while [ $# -gt 0 ]; do
 if [ "$1" = "-n" ]; then
   name="$2"
   shift 2
 elif [ "$1" = "-p" ]; then
   price="$2"
   shift 2
 elif [ "$1" = "-f" ]; then
   file_name="$2"
   shift 2
 else
   shift 1
 fi
done

if ! echo "$price" | grep -q '^[0-9]*$';then
echo "Error: The price must be an integer."
echo "Error: The price must be an integer." >> err.log
exit 1
fi 

if [ ! -e "$file_name" ]; then
echo "Error: The file does not exist."
echo "Error: The file does not exist." >> err.log
exit 1
fi

if [ -e "$file_name" ]; then

echo "$name $price">>"$file_name"

else

echo "$name $price" > "$file_name"
fi

exit 0 
