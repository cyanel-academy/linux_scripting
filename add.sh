#!/bin/sh
resultat=$(echo "$1 + $2" | bc)
echo "$resultat"

