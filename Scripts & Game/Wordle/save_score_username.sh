#!/bin/bash

# initialisation of the different variables
username="$1"
filename="scores.txt"

# if the file doesn't exist, create it
touch "$filename"

# get the current score of the player
current_score=$(grep "^${username}" "$filename" | cut -f2)

# if current_score has a number, the player exists (we change the number of wins), else, it's a new player
if [ -n "$current_score" ]; then
	new_score=$((current_score + 1))

	# we directly change the file at the username's line and replace the current with new score
	sed -i "s/^${username}\t.*/${username}\t${new_score}/" "$filename"
else
	printf "%s\t1\n" "$username" >> "$filename"
fi

exit 0
