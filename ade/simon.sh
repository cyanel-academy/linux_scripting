#!/bin/bash

SCORE_FILE="scores_simon.txt"

# Fonction pour afficher le top 10
show_top10() {
    echo -e "\n--- CLASSEMENT TOP 10 ---"
    if [ -f "$SCORE_FILE" ]; then
        # On trie par le score (colonne 2) de façon numérique inversée
        sort -t':' -k2 -nr "$SCORE_FILE" | head -n 10
    else
        echo "Aucun score pour le moment."
    fi
}

# 1. Demander le nombre de joueurs
read -p "Combien de joueurs ? " nb_players

for (( i=1; i<=nb_players; i++ ))
do
    read -p "Pseudo du joueur $i : " player_name
    echo "Préparez-vous $player_name... Le Simon commence !"
    sleep 1

    sequence=""
    game_over=0
    score=0

    while [ $game_over -eq 0 ]
    do
        # Ajouter une lettre aléatoire parmi Q, S, D, F
        chars="QSDF"
        new_char=${chars:$(( RANDOM % 4 )):1}
        sequence="$sequence$new_char"

        # Afficher la séquence
        echo -e "\nRetenez bien : $sequence"
        sleep 2
        clear # Efface l'écran

        # Demander la réponse
        read -p "Répétez la séquence : " user_input
        # Convertir en majuscules pour éviter les erreurs de frappe
        user_input=${user_input^^}

        if [ "$user_input" == "$sequence" ]; then
            score=$((score + 1))
            echo "Bien joué ! Score actuel : $score"
        else
            echo "FAUX ! *SLAP* (Gifle virtuelle)"
            game_over=1
        fi
    done

    # Gestion du fichier de score (Originalité : stockage format CSV simple)
    # On ajoute d'abord le nouveau score
    echo "$player_name:$score" >> "$SCORE_FILE"
    
    # On garde seulement la meilleure performance si le joueur existe déjà
    # et on nettoie pour ne garder que le top 10 global
    tmp_file=$(mktemp)
    sort -t':' -k1,1 -k2,2nr "$SCORE_FILE" | sort -u -t':' -k1,1 > "$tmp_file"
    sort -t':' -k2,2nr "$tmp_file" | head -n 10 > "$SCORE_FILE"
    rm "$tmp_file"

    show_top10
done