#!/bin/sh

read -p "What is the product name? (Type the name)..." pname

read -p "What is the price? (Type the price)..." price


printf "%-20s|%.2f\n" "$(echo "$pname" | tr '[:lower:]' '[:upper:]')" "$price"
