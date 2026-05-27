#!/bin/sh
printf "%-20s|%.2f\n" "$(echo "$1" | tr '[:lower:]' '[:upper:]')" "$2"



