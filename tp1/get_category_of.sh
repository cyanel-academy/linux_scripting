#!/bin/bash


instrument="$1"


echo "$instrument_categorie"


case "$instrument" in
    Piano|drum|djumbe|tambourine)
        echo "percussion"
        ;;
    Ukulele|guitar|bass|banjo)
        echo "strings"
        ;;
        *)
        echo "unknown"
        ;;
esac
