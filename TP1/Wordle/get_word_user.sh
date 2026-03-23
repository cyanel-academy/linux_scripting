#!/bin/bash

wordle_word=$1

printf "Enter a word of 5 caracters: "
# read input value
read user_word

./check_user_word.sh $user_word $wordle_word

exit 0
