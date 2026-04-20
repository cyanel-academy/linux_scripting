#!/bin/bash

# 1. Demander le nom (pour le top 10 plus tard)
echo "Entrez votre nom :"
read username

points=0
sequence=""
lettres=("Q" "S" "D" "F")

while true
do
    # 2 & 5. Ajouter une lettre au hasard
    nouvelle_lettre=${lettres[$((RANDOM % 4))]}
    sequence="$sequence$nouvelle_lettre"

    # Afficher la séquence
    clear
    echo "Retiens bien : $sequence"
    sleep 2
    
    # 3 & 6. Effacer l'écran
    clear

    # 4. L'utilisateur doit répéter
    echo "$username, à toi ! Tape la séquence :"
    read reponse

    # 7. Vérifier si c'est bon
    if [ "$reponse" == "$sequence" ]; then
        points=$((points + 1))
        echo "Bien joué ! Score : $points"
        sleep 1
    else
        echo "MAUVAISE SÉQUENCE !"
        echo "Slap ! :)" # La petite consigne rigolote du prof
        echo "Ton score final est : $points"
        
        # Ici il faudra ajouter la partie 8 (Top 10) plus tard
        break
    fi
done
