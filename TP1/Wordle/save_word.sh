#!/bin/bash

# initialisation of the different variables
word=$1
filename=$2

if ! [ ${#word} -eq 5 ]; then 	# chech if the word is exactly 5 caracters
    printf "ERROR: %s is not exactly 5 caracters!\n" "$word"
    exit 1

else
    # puts the word given filename (creates the file if not existing)
    printf "$word\n" >> $filename
    printf "%s inserted in %s!\n" "$word" "$filename"

fi

exit 0
