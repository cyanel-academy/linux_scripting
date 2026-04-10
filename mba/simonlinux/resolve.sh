#!/bin/bash
read -p "Entrer l'expression ; " EXP
echo "$EXP" | tr '[' '(' | tr ']' ')' | bc
