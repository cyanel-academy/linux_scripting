#!/bin/sh

number1=$1
number2=$2

result=$(echo "$number1+$number2" | bc)

echo "Hello, $number1 + $number2 =  $result" 

exit 0
