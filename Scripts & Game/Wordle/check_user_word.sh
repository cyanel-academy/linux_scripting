#!/bin/bash

user_word_to_check=$1
wordle_word=$2
green_count=0

GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

printf "\t"
# checks one by one all letters from the user word if it matches with the letters from the wordle word
for ((i=0; i<${#user_word_to_check}; i++)); do
	uw="${user_word_to_check:$i:1}" # user word letter i
	ww="${wordle_word:$i:1}"	# wordle word letter i

	if [ "$uw" = "$ww" ]; then
		printf "${GREEN}%s${RESET}" "$uw"
		green_count=$((green_count + 1))
	elif [[ "$wordle_word" == *"$uw"* ]]; then # checks if in the wordle word, the uw caracter exists
		printf "${YELLOW}%s${RESET}" "$uw"
	else
		printf "$uw"
	fi
done
printf "\n"

# stores the number of green caracters in a tmp file (the > overwrites the data)
echo "$green_count" > /tmp/wordle_green_cpt.txt

exit 0
