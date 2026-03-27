#!/bin/sh

a=$1
b=$2
result=$(echo "$a + $b"| bc)
echo "Hello, $a + $b = $result" 
