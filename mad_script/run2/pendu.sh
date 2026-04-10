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
}

# Fonction pour choisir un mot au hasard
choose_word() {
    word=$(sort -R $DEFAULT_WORDS | head -1) #sort mélange les lignes aléatoirement et head prend la première ligne
    echo $word
}

# Fonction pour afficher le mot masqué
display_word() {
    local word=$1
    local found=$2
    local display=""
    for (( i=1; i<=${#word}; i++ )); do
        local letter="${word:i-1:1}"
        
        if [[ $found == *"$letter"* ]]; then
            display="$display $letter"
        else
            display="$display _"
        fi
    done
    echo $display
}

# Fonction principale du jeu
play_game() {
    local player=$1
    local word=$(choose_word)
    local found=""
    local errors=0
    local score=0
    local guessed=0

    echo ""
    echo "---- Tour de $player ---"
    echo "Le mot a ${#word} lettres"
    echo ""

    while [ $errors -lt $MAX_ERRORS ] && [ $guessed -eq 0 ]; do
        draw_pendu $errors
        echo ""
        display_word "$word" "$found"
        echo ""
        echo "Lettres essayées : $found"
        echo "Erreurs: $errors / $MAX_ERRORS"
        echo ""
        read -p "Propose une lettre : " letter
        letter=$(echo "$letter" | tr 'a-z' 'A-Z')
        if [[ $found == *"$letter"* ]]; then
            echo "Tu as déjà proposé cette lettre!"
            continue
        fi
        found="$found$letter"
        if [[ $word == *"$letter"* ]]; then
            echo "GOOD !"
            score=$((score + 10))
        else
            echo "BAD, try again"
            score=$((score - 5))
            errors=$((errors + 1))
        fi
        local masked=$(display_word "$word" "$found")
        if [[ $masked != *"_"* ]]; then
            guessed=1
        fi
    done

    echo ""
    draw_pendu $errors
    echo ""
    if [ $guessed -eq 1 ]; then
        echo "Bravo $player ! Tu as trouvé le mot: $word"
    else
        echo "Perdu $player! Le mot était: $word"
    fi
    echo "Score: $score points"
    echo ""
}

main() {
     local nb_players=""

     while  getopts "p:w:" option; do  
          case $option in
          p) nb_players=$OPTARG ;;
          w)DEFAULT_WORDS=$OPTARG ;;
          ?)
             echo "Usage: ./pendu.sh -p [nb_joueurs] -w [fichier_mots]"
             exit 1 ;;
          esac
     done

     if [ -z "$nb_players" ]; then  
        read -p "Combien de joueurs ? " nb_players
     fi

     #Pour demander le nom de chaque joueur et stocker
     local players=()
     for ((i=1; i<=nb_players;i++)); do
         read -p "Nom du joueur $i : " name
         players+=("$name")
     done

     #Pour faire jouer chaque participant
     for player in "${players[@]}"; do
         play_game "$player"
     done
}

#lancer le programme en passant par tous les arguments
#main "$@"