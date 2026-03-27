#!/bin/bash
nom=$(echo "$1" | tr '[:lower:]' '[:upper:]')
prix="$2"
printf "%-15s | %10.2f\n" "$nom" "$prix"

