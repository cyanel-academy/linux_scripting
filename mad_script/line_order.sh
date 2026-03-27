#!/bin/sh

name=$1
price=$2
 
printf "%-20s|%.2f\n" "$(echo "$1" | tr '[:lower:]''[:upper:]')" "$2"
