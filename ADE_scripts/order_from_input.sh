#!/bin/sh

echo "What is the product name ? (type a value)"
read name_response

echo "What is the price ? (type a value)"
read price_response

./line_order.sh "$name_response" "$price_response"

exit 0
