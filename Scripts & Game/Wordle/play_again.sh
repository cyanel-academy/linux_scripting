#!/bin/bash

filename=$1

printf "Play again ? (yes/no) :  "
# read input value
read user_input

case "$user_input" in
    yes|y)
        #printf -- "----- NEW GAME -----\n"
        exit 0	# the code to indicate that the game continues
        ;;
    no|n)
        printf -- "\n----- END OF GAME -----\n\n" # -- to say no option and let the - in the printf
	
	echo "-----------------------------"
	printf "%20s\n\n" "SCORE TABLE"

	rank=1
    	# we get all the fields from the file
	printf "%-6s %-15s\t%s\n" "RANK" "USERNAME" "SCORE"
	# we sort the file's content by the number of wins and get the 10 best (first)
	sort -k2,2nr "$filename" | head -n 10 | while read usr score; do
		printf "#%-5d %-15s\t%d\n" "$rank" "$usr" "$score"
		rank=$((rank + 1))
    	done

    	echo "-----------------------------"
        ;;
    *)
        printf -- "\n----- INVALID INPUT/END OF GAME -----\n\n"
        ;;
esac

exit 1		# the code to indicate that the game ends
