#!/bin/sh

echo "What is the product name? (type a value)"
# read input value
read product
echo "What is the price? (type a value)"
read price

./line_order.sh $product $price

exit 0