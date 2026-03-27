#!/bin/bash
echo "wath is the product name? (type a value)"
read produit_brut
echo "wath is the price? (type a value)"
read prix
produit=$(echo "$produit_brut" | tr '[:lower:]' '[:upper:]')
printf "%-15s | %10.2f\n" "$produit" "$prix"
