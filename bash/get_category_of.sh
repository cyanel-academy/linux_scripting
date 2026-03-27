#!/bin/sh

instrument=$1

case "$instrument" in
  Piano|drum|djembe)
  echo "persussion"
;;
 Ukulele|guitar|bass|banjo) 
  echo "strings"
;;
*)
echo "unknow"
 ;;

esac
