#!/bin/bash

SCORE_FILE="scores_simon.txt"

#KEYS="QSDF"  
#NB_KEYS=${#KEYS} 
#TOP_LIMIT=10  

SLEEP_PRE=1         
SLEEP_MEM=2        
CONTINUE_GAME=0         
EXIT_GAME=1             
          

# F pour afficher le top 10 (utilisé en fin)
show_top10() {
    echo -e "\n ***CLASSEMENT TOP 10***"
    if [ -f "$SCORE_FILE" ]; then
        # On trie par le score
        sort -t':' -k2 -nr "$SCORE_FILE" | head -n 10
    else
        echo "Aucun score pour le moment :'( "
    fi
}

# nombre de joueurs ?
read -p "Bienvenue dans "SIMON". Combien de joueurs ? " nb_players    #AMELIORATIONS / creation de tableau avec LISTE du noms des users 

for (( i=1; i<=nb_players; i++ )) #commencer par i =0 et faire une equivalence entre la place dans le tableau et i=0
do
    read -p "Pseudo du joueur $i : " player_name
    echo " Dear #$player_name, le jeu va commencer..."
    sleep "$SLEEP_PRE"

    sequence=""
    game_over=$CONTINUE_GAME
    score=0

    while [ "$game_over" -eq "$CONTINUE_GAME" ]
    do
        # on va ajouter une lettre aléatoire parmi Q, S, D, F
        chars="QSDF"
        new_char=${chars:$(( RANDOM % 4 )):1}
        sequence+=$new_char

        # la séquence
        echo -e "\nRetenez bien la sequence suivante : $sequence"
        sleep $SLEEP_MEM
        clear 

        # la réponse
        read -p "Répétez la séquence svp : " user_input

        # majuscules 
        user_input=${user_input^^}

        if [ "$user_input" == "$sequence" ]; then
            score=$((score + 1))
            echo "Bien joué !!! Score actuel : $score"
        else
            echo "GaMe OvEr !!! (>_<)"                                  
            game_over=$EXIT_GAME
        fi
    done

    # fichier score 
    # On ajoute d'abord le nouveau score
    echo "$player_name:$score" >> "$SCORE_FILE"
    
    # meilleure performance si --> le joueur existe déjà
    # et on nettoie pour ne garder que le top 10 global
    tmp_file=$(mktemp)
    sort -t':' -k1,1 -k2,2nr "$SCORE_FILE" | sort -u -t':' -k1,1 > "$tmp_file"
    sort -t':' -k2,2nr "$tmp_file" | head -n 10 > "$SCORE_FILE"
    rm "$tmp_file"

    show_top10
done



#-------------- timer possibility 
#timer =15;
#seuil=0
#while [ $timer -ge "seuil" ];do
#seuil+=1
#echo "$seuil"
#sleep 1
#et select a voir, mais c'est du high level
#--------------