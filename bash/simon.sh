#!/bin/bash

ask_question() {
echo "$1"
read answer
answer=$(echo "$answer" | tr -d '\r')
}

score_file="scores.txt"
valid_keys="QSDF"
playing="true"
sequence=""
round=0

clear
echo "BIENVENUE DANS LE SIMON"

ask_question "Quel est ton nom, joueur?"
player_name="$answer"

if [ -z "$player_name" ]; then
 player_name="Anonyme"
fi

echo "Bonjour $player_name ! Retiens la séquence"

sleep 1

ask_question "ARE YOU READY? ('y' pour oui)"

if [ "$answer" != "y" ] && [ "$answer" != "Y" ]; then
 echo "Dommage... Reviens plus tard misérable..."
 exit 0
fi

while [ "$playing" = "true" ]; do

round=$((round+1))

choix=$((RANDOM % 4))

if [ "$choix" -eq 0 ]; then
 new_letter="Q"
elif [ "$choix" -eq 1 ]; then 
 new_letter="S"
elif [ "$choix" -eq 2 ]; then 
 new_letter="D"
else
 new_letter="F"
fi

sequence="$sequence$new_letter"

clear
echo "---TOUR $round ---"
echo ""
echo "SEQUENCE A RETENIR"
echo "$sequence"

sleep 2 

clear
echo "---TOUR $round ---"
echo ""

ask_question "A TOI DE JOUER ! répète la séquence sans espaces: "

player_input=$(echo "$answer" | tr '[:lower:]' '[:upper:]')

if [ "$player_input" = "$sequence" ]; then
clear
echo "BIEN JOUER, SCORE + 1 "
sleep 1 

else
playing="false"
clear 
echo "FAUX ! "
sleep 1 
fi 
done

score=$((round-1))

clear
echo "GAME OVER"
echo ""
echo "PERDU $player_name (looser), la bonne séquence était $sequence"
echo "Ton score est: $score"

if [ ! -e "$score_file" ]; then
 touch "$score_file"
fi 

grep -v "$player_name" "$score_file" > brouillon.txt 2>/dev/null

echo "$score $player_name" >> brouillon.txt

sort -nr brouillon.txt | head -n 10 > "$score_file"
rm brouillon.txt

echo "TABLEAU DES SCORES (TOP 10)... Les moins misérables"
echo""

cat "$score_file"

exit 0


