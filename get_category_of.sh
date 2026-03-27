#!/bin/sh

instrument=$1

if [ "$instrument" = "piano" ] || [ "$instrument" = "drum" ] || [ "$instrument" = "djumbe" ] || [ "$instrument" = "tambourine" ]; then
	echo "percussion"
elif [ "$instrument" = "ukulele" ] || [ "$instrument" = "guitar" ] || [ "$instrument" = "bass" ] || [ "$instrument" = "banjo" ]; then
	echo "strings"
else 
	echo "unknown"
fi 
 
