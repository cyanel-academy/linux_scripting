#!/bin/sh

#Paramètres initiales

SCORE_FILE="scores.txt"
DEFAULT_WORDS="words.txt"
MAX_ERRORS=6

#Fonction
draw_pendu() {
       local errors=$1
       echo "  |------|"

#en cas d'erreur
if [$errors -ge 1 ]; then
     echo " | o "
else
     echo " | "
fi

#corps du pendu
if [ $errors -ge 4 ]; then
    echo " | /|\ "
elif [ $errors -ge 3 ]; then
     echo " | /| "
elif [$errors -ge 2 ]; then
     echo " | | "
else
     echo " | "
fi

#jambes du pendu
if [ $errors -ge 6 ]; then
     echo " | /\ "
elif [ $errors -ge 5 ]; then
     echo " | "
fi

echo " | "
echo " _|_ "
