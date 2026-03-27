#!/bin/bash

read -p "What is the product name? " name #le name est stocké dans la variable $name
read -p "What is the price? " price #le price est stocké dans la variable $price

./line_order.sh "$name" "$price"