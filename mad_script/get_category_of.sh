#!/bin/sh

if [$# -ne 1 ]; then
   echo "Wrong number of parameters. Usage: ./get_category_of.sh [name]"
   exit 1
fi

instrument=$(echo "$1" | tr '[:upper:]' '[:lower:]')

case "$instrument" in
     piano|drum|djumbe|tambourine)
       echo "percussion"
       ;;
     ukulele|guitar|bass|banjo)
       echo "strings"
       ;;
     *)
       echo "unknown"
       ;;
esac

exit 0
