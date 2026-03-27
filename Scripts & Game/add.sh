#!/bin/sh

v1=$1
v2=$2

somme=$(echo "$v1+$v2" | bc) #$() exec command inside & assign to variable

echo "Hello, $v1 + $v2 = $somme"

exit 0