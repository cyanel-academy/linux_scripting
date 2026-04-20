#!/bin/bash


if [ $# -ne 3 ]; then
  echo "Wrong number of parameters. Usage ./save_line_order [product] [price] [file]"
  exit 1
fi


echo "$1 | $2" >> "$3"


if [ $? -eq 0 ]; then
  echo "Order inserted"
  exit 0
else
  echo "Error: Could not write to file"
  exit 1
fi
