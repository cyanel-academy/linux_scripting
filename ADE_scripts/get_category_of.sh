#!/bin/sh

name=$(echo "$1" | tr '[:upper:]' '[:lower:]')

case "$name" in

    "piano"|"drum"|"djumbe"|"tambourine")
    category="percussion"
    ;;

    "ukulele"|"guitar"|"bass"|"banjo")
    category="strings"
    ;;

    *)
    category="unknown"
    ;;

esac

echo "$category"
exit 0