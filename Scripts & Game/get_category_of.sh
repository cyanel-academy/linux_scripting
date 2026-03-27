#!/bin/bash

# initialisation of the variable
name=$1

# get the name of the instrument and return the category
case "$name" in
	piano|drum|djumbe|tambourine) printf "percussion" ;;
	ukulele|guitar|bass|banjo) printf "string" ;;
	*) printf "unknown" ;;
esac
