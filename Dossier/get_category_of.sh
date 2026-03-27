#!/bin/sh

# Vérifier si l'utilisateur a fourni un argument
if [ "$#" -ne 1 ]; then
  echo "Error : Give an instrument!!!!" 
  echo "Please use this script: $0 <instrument_name>"
  exit 1
fi

instrument="$1"

case "$instrument" in
  # catégorie percussion
  "piano" | "drum" | "djumbe" | "tambourine")
    echo "Percussion"
    ;;
  
  # catégorie strings
  "ukulele" | "guitar" | "bass" | "banjo")
    echo "Strings"
    ;;
  
  # Autres instruments
  *)
    echo "Unknown"
    ;;
esac

exit 0
