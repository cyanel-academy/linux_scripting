#!/bin/bash

GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

word_to_guess=$(shuf -n 1 word.txt) # get one random word in the word.txt file
word_found=0
tries=5
filename="scores.txt"

printf -- "${GREEN}\n------------------------\n"
printf "\tWORDLE!\n"
printf -- "------------------------\n\n${RESET}"

username=$(./get_username.sh)

printf "\n${RED}Guess the 5 letter word !\n\n${RESET}"

while [[ $tries -ne 0 && $word_found -ne 1 ]]; do
    ./get_word_user_to_check.sh $word_to_guess

    green_cpt=$(cat /tmp/wordle_green_cpt.txt)  # get the number of green letters (well places letters) in the input word
    #echo "DEBUG : Nb of green letters=$green_cpt"
    if [[ green_cpt -eq 5 ]]; then
        word_found=1
    fi

    tries=$((tries - 1))
    #echo "DEBUG : tries=$tries"
done

if [[ word_found -ne 1 ]]; then
    printf -- "\n-----------------\n"
    printf "NO MORE TRIES !\n" $word_to_guess
    printf "THE WORD WAS %s !\n" $word_to_guess
    printf -- "-----------------\n\n"
    
else
    ./save_score_username.sh "$username"
    printf -- "\n------------------------\n"
    printf "YOU FOUND THE WORD (%s)!\n" $word_to_guess
    printf -- "------------------------\n\n"
fi

./play_again.sh "$filename"

exit 0
