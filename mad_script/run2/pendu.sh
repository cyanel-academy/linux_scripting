#!/bin/bash

# Paramètres initiaux
SCORE_FILE=~/run2/scores.txt
DEFAULT_WORDS=~/run2/words.txt
MAX_ERRORS=6

# Fonction dessin pendu
draw_pendu() {
                local errors=$1
                echo "  |------|"
                if [ $errors -ge 1 ]; then
                    echo "  |      o"
                else
                    echo "  |"
                fi
                if [ $errors -ge 4 ]; then
                    echo "  |     /|\ "
                elif [ $errors -ge 3 ]; then
                    echo "  |     /|"
                elif [ $errors -ge 2 ]; then
                    echo "  |      |"
                else
                    echo "  |"
                fi
                if [ $errors -ge 6 ]; then
                    echo "  |     / \ "
                elif [ $errors -ge 5 ]; then
                    echo "  |     /"
                else
                    echo "  |"
                fi
                echo "  |"
                echo " _|_"
}


# Fonction pour choisir un mot au hasard
choose_word() {
    word=$(shuf -n 1 $DEFAULT_WORDS)
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
    update_score "$player" "$score"
    show_top10
}

# Fonction pour mettre à jour le top 10
update_score() {
    local player=$1
    local score=$2

    if [ ! -f "$SCORE_FILE" ]; then
        touch "$SCORE_FILE"
    fi

    if grep -q "^$player:" "$SCORE_FILE"; then
        old_score=$(grep "^$player:" "$SCORE_FILE" | cut -d':' -f2)
        new_score=$((old_score + $score))
        sed -i "s/$player:.*/$player:$new_score/" "$SCORE_FILE"
    else
        echo "$player:$score" >> "$SCORE_FILE"
    fi

    sort -t':' -k2 -rn "$SCORE_FILE" | head -10 > tmp_score.txt
    mv tmp_score.txt "$SCORE_FILE"
}

# Fonction pour afficher le top 10
show_top10() {
    echo ""
    echo "~~~~~~~~~~~~~~ TOP 10 ~~~~~~~~~~~"
    echo ""
    if [ ! -f "$SCORE_FILE" ] || [ ! -s "$SCORE_FILE" ]; then
        echo "Pas encore de scores"
    else
        local rank=1
        while IFS=':' read -r name score; do
            printf "%-3s %-15s %10s points\n" "$rank." "$name" "$score"
            rank=$((rank + 1))
        done < "$SCORE_FILE"
    fi
    echo ""
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo ""
}

# Gestion des arguments et lancement du jeu
main() {
    local nb_players=""

    while getopts "p:w:" option; do
        case $option in
            p) nb_players=$OPTARG ;;
            w) DEFAULT_WORDS=$OPTARG ;;
            ?)
                echo "Usage: ./pendu.sh -p [nb_joueurs] -w [fichier_mots]"
                exit 1 ;;
        esac
    done

    if [ -z "$nb_players" ]; then
        read -p "Combien de joueurs ? " nb_players
    fi

    local players=()
    for ((i=1; i<=nb_players; i++)); do
        read -p "Nom du joueur $i : " name
        players+=("$name")
    done

    for player in "${players[@]}"; do
        play_game "$player"
    done
}

# Lancer le programme
main "$@"