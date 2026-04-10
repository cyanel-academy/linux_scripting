#!/bin/bash

if [ "$#" -ne 0 ]; then 
	echo "No parameters needed for this command. Usage ./simon.sh"
	echo "Wrong number of parameters" > err.log
	exit 1
fi

echo "Hi ! WELCOME to Simon game... First, what's your name ?"
read player_name

echo -e "\nThanks ! LET'S BEGIN :) (press anything to begin)" # -e pour prendre en compte les caractères d'échappement
read user_entry
clear

score=0
egal=1

file_scores="high_scores_simon_game.txt"

liste_de_lettres="QSDF"
sequence_to_display=""

while [ $egal = 1 ]; do

    #On va choisir un nombre au hasard entre 1 et 4, pour aller piocher la Xè lettre dans la liste
    #numero=$(shuf -i 1-4 -n 1) # shuf est comme un random, mais en sh
    numero=$(( (RANDOM % 4) + 1 )) # génère un nombre entre 0 et 3 et décale de 1 pour avoir entre 1 et 4
    #en input on dit les chiffres entre 1 et 4 et on veut en sortie 1 seul chiffre

    letter_to_add=$(echo "$liste_de_lettres" | cut -c "$numero")
    sequence_to_display="$sequence_to_display$letter_to_add"

    echo -e "REMEMBER the sequence !\n$sequence_to_display"
    sleep 2
    clear
    echo "YOUR TURN ! Repeat the sequence :"
    read user_sequence
    user_sequence=$(echo "$user_sequence" | tr '[:lower:]' '[:upper:]') #on met en maj au cas où l'utilisateur ne le fait pas


    if [ "$user_sequence" != "$sequence_to_display" ]; then
        egal=0
    else
        score=$(echo "$score + 1" | bc)
        echo -e "Good ! +1\nLet's make another round !"
        sleep 1
        clear
    fi

done

echo "Wrong !!!!!"
echo "Your SCORE is $score."


touch "$file_scores" # cree le fichier si il n'existe pas

echo "$score $player_name" >> "$file_scores" #on rajoute dans le top 10 le dernier score
#on va trier cette liste de score pour garder les 10 meilleurs dans le bon ordre décroissant

tmp_file="scores.tmp"

sort -k2,2 -k1,1rn "$file_scores" | sort -u -k2,2 | sort -rn > "$tmp_file"
# On trie d'abord par nom (2e colonne) puis par score du plus grand au plus petit
# Puis on garde seulement la 1ere occurence d'un nom si il est en doublon
# Et on trie de façon décroissante pour avoir le score le plus haut en premier
head -n 10 "$tmp_file" > "$file_scores"
rm "$tmp_file"

echo -e "\n--- TOP 10 HIGH SCORES ---"
cat "$file_scores"

