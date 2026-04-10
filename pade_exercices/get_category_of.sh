#!/bin/bash

#Vérif paramètre
if [ $# -ne 1 ]; then
    echo "Usage: ./get_category_of.sh [instrument_name]"
    exit 1
fi

#Convertir en minuscules
instrument=$(echo "$1" | tr '[:upper:]' '[:lower:]')

#CASE pour les catégories
case $instrument in
    "piano" | "drum" | "djumbe" | "tambourine")
        echo "percussion"
        ;;
    "ukulele" | "guitar" | "bass" | "banjo")
        echo "strings"
        ;;
    *)
        echo "unknown"
        ;;
esac