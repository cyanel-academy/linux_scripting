#!/bin/bash
num1="$1"
num2="$2"
resultat=$(echo "$num1 + $num2"|bc)
echo "Hello, $num1 + $num2 = $resultat"
