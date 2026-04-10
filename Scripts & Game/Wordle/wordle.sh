#!/bin/bash

GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

# we start the game (infinit loop)
while true; do
	word_found=0
	tries=5
	filename="scores.txt"
	word_filename="word.txt"

	# get the random word from the file
	num_words=$(wc -l < "$word_filename")				# get the number of word in the word data file
	chosen_word_num=$(( 1 + RANDOM % $num_words ))			# get a random
	word_to_guess=$(sed -n "${chosen_word_num}p" "$word_filename")

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
	    printf -- "\n----------------------\n"
	    printf "NO MORE TRIES !\n"
	    printf "THE WORD WAS %s !\n" $word_to_guess
	    printf -- "----------------------\n\n"
	    
	else
	    ./save_score_username.sh "$username"
	    printf -- "\n------------------------\n"
	    printf "YOU FOUND THE WORD (%s)!\n" $word_to_guess
	    printf -- "------------------------\n\n"
	fi
	
	if ./play_again.sh "$filename"; then	# check the return code from play again (here code = 0)
		#word_found=0	# reset the word-found value
		continue	# restart the game
	else	# code = 1
		break		# end of game
	fi
done

exit 0
