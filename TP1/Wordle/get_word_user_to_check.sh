#!/bin/bash

wordle_word=$1

while true; do
    printf "Enter a word of 5 caracters: "
    # read input value
    read user_word

    if [[ ${#user_word} -eq 5 ]]; then
        # delete the input request line
        tput cuu1   # go back one line
        tput el     # delete the line
        break;
    fi
    # delete the input request line
    tput cuu1   # go back one line
    tput el     # delete the line
done

# calls the function that compares the wordle and user word
./check_user_word.sh "$user_word" "$wordle_word"

exit 0
