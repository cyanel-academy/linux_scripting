#!/bin/bash

# initialisation of the different variables
username="$1"
filename="scores.txt"

# if the file doesn't exist, create it
touch "$filename"

# get the current score of the player
current_score=$(grep -P "^${username}\t" "$filename" | cut -f2)

if [ -n "$current_score" ]; then
	new_score=$((current_score + 1))

	sed -i "s/^${username}\t.*/${username}\t${new_score}/" "$filename"
else
	printf "%s\t1\n" "$username" >> "$filename"
fi
