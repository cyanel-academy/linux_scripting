#!/bin/bash

# Constantes :
CONTINUE_VALUE=1
EXIT_VALUE=0
SLEEP_TRANSITION_TIME=1
SLEEP_TIME_BEGINNER=5
SLEEP_TIME_INTERMEDIATE=2
SLEEP_TIME_EXPERT=1
SLEEP_TIME_DEFAULT=2


# On vérifie qu'il n'y a pas d'arguments entrés
if [ "$#" -ne 0 ]; then 
	echo "No parameters needed for this command. Usage ./simon.sh"
	echo "Wrong number of parameters" > err.log
	exit 1
fi


# Début du jeu
echo "Hi ! WELCOME to Simon game... First, what's your name ?"
read player_name # à condenser avec un message dans le rea
# Faire read -p "Mon message" ma_variable

echo -e "\nWhat are the letters you want to play with ? Example : QSDF" # -e pour prendre en compte les caractères d'échappement
read letters_list

number_of_letters=${#letters_list}

echo -e "\nSelect your level : Beginner (press B), Intermediate (press I), Expert (press E)"
read level
level=$(echo "$level" | tr '[:lower:]' '[:upper:]') # On met en maj au cas où l'utilisateur ne le fait pas
# Penser à rajouter de la robustesse

case "$level" in

    "B")
    sleep_time=$SLEEP_TIME_BEGINNER
    ;;

    "I")
    sleep_time=$SLEEP_TIME_INTERMEDIATE
    ;;

    "E")
    sleep_time=$SLEEP_TIME_EXPERT
    ;;

    *)
    sleep_time=$SLEEP_TIME_DEFAULT
    ;;

esac

echo -e "\nThanks ! LET'S BEGIN :) (press anything to begin)"
read user_entry
clear


score=0
is_equal=$CONTINUE_VALUE
file_scores="high_scores_simon_game.txt"
tmp_file="scores.tmp"
sequence_to_display=""


while [ $is_equal = $CONTINUE_VALUE ]; do

    # On va choisir un nombre au hasard entre 1 et le nombre max de lettres dans la liste, pour aller piocher la nième lettre dans la liste
    numero=$(( (RANDOM % $number_of_letters) + 1 ))

    letter_to_add=$(echo "$letters_list" | cut -c "$numero")
    sequence_to_display="$sequence_to_display$letter_to_add"

    echo -e "REMEMBER the sequence !\n$sequence_to_display"
    sleep $sleep_time
    clear
    echo "YOUR TURN ! Repeat the sequence :"
    read player_sequence
    player_sequence=$(echo "$player_sequence" | tr '[:lower:]' '[:upper:]') # On met en maj au cas où l'utilisateur ne le fait pas


    if [ "$player_sequence" == "$sequence_to_display" ]; then # Le joueur a bon
        score=$(echo "$score + 1" | bc)
        echo -e "Good ! +1\nLet's make another round !"
        sleep SLEEP_TRANSITION_TIME
        clear
    else # Le joueur a faux
        is_equal=$EXIT_VALUE
    fi

done


echo "Wrong !!!!! GAME OVER"
echo "Your SCORE is $score."


touch "$file_scores" # Crée le fichier si il n'existe pas

echo "$score $player_name" >> "$file_scores" # On rajoute dans le top 10 le dernier score
# On va trier cette liste de score pour garder les 10 meilleurs dans le bon ordre décroissant

sort -k2,2 -k1,1rn "$file_scores" | sort -u -k2,2 | sort -rn > "$tmp_file"
# On trie d'abord par nom (2e colonne) puis par score du plus grand au plus petit
# Puis on garde seulement la 1ere occurence d'un nom si il est en doublon
# Et on trie de façon décroissante pour avoir le score le plus haut en premier
head -n 10 "$tmp_file" > "$file_scores" # On garde les 10 premières lignes pour faire le top 10
rm "$tmp_file" # On efface le fichier temporaire

echo -e "\n--- TOP 10 HIGH SCORES ---"
cat "$file_scores" # Affichage du fichier de scores

