#!/bin/sh


if[-z "$1"];then
      echo"Argument 1 is missing"
      exit 1
elif[-z "$2"];then
      echo "Argument 2 is missing"
      exit 1
fi

value1=$1
value2=$2

echo "$1 + $2" | bc

exit 0
