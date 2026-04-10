#!/bin/bash
# Jeu du Dilemme du Prisonnier - Architecture Event Loop (Non-bloquante)

MAIN_PID=$$
declare -a HISTORY_ME
declare -a HISTORY_THEM

# ==========================================
# 1. GESTION DES SIGNAUX
# ==========================================
cleanup() {
    echo -e "\n\033[31m[Système] Fermeture et destruction des tunnels...\033[0m"
    kill $(jobs -p) 2>/dev/null
    rm -f /tmp/pdgame_*
    exit 0
}
trap cleanup INT TERM EXIT

# ==========================================
# 2. INITIALISATION DU RÉSEAU (Line-Buffering)
# ==========================================
rm -f /tmp/pdgame_* 2>/dev/null
mkfifo /tmp/pdgame_net_in /tmp/pdgame_net_out
chmod 666 /tmp/pdgame_net_in /tmp/pdgame_net_out

MODE=$1
if [[ "$MODE" == "host" ]]; then
    echo "[Système] Vous êtes l'Hôte."
    echo "[Système] En attente que l'adversaire se connecte via SSH..."
elif [[ "$MODE" == "client" ]]; then
    TARGET=$2
    PORT=${3:-2222}
    if [[ -z "$TARGET" ]]; then echo "Erreur: Cible requise."; exit 1; fi
    echo "[Système] Établissement des tunnels SSH vers $TARGET:$PORT..."
    
    ( while read -r line; do echo "$line"; done < /tmp/pdgame_net_out ) | ssh -q -p "$PORT" "$TARGET" "cat >> /tmp/pdgame_net_in" &
    ssh -q -p "$PORT" "$TARGET" "while read -r line; do echo \"\$line\"; done < /tmp/pdgame_net_out" > /tmp/pdgame_net_in &
else
    echo "Usage Host   : $0 host"
    echo "Usage Client : $0 client user@ip [port]"
    exit 1
fi

exec 3> /tmp/pdgame_net_out
exec 4< /tmp/pdgame_net_in

# ==========================================
# 3. LECTURE RÉSEAU
# ==========================================
network_reader() {
    while read -r line <&4; do
        prefix="${line%%:*}"
        content="${line#*:}"
        content=$(echo "$content" | tr -d "\r") 
        
        if [[ "$prefix" == "MSG" ]]; then
            echo -e "\r\033[K\033[36m[Adversaire]\033[0m : $content"
        elif [[ "$prefix" == "CMD" ]]; then
            subcmd="${content%%:*}"
            subval="${content#*:}"
            case "$subcmd" in
                SYNC) touch /tmp/pdgame_sync ;;
                CHOSE)
                    touch /tmp/pdgame_remote_chose
                    echo -e "\r\033[K\033[33m[Système] L'adversaire a fait son choix !\033[0m"
                    ;;
                CHOICE) echo "$subval" > /tmp/pdgame_remote_choice ;;
            esac
        fi
    done
}
network_reader &

# ==========================================
# 4. SYNCHRONISATION
# ==========================================
echo "CMD:SYNC" >&3
echo "[Système] Attente de la synchronisation avec l'autre joueur..."
while [[ ! -f /tmp/pdgame_sync ]]; do sleep 0.5; done
echo -e "\033[32m[Système] Connexion établie ! Le jeu commence.\033[0m"
sleep 2

# ==========================================
# 5. BOUCLE DE JEU (PHASE SECRÈTE)
# ==========================================
for round in {1..5}; do
    echo -e "\n==================================="
    echo -e "          MANCHE $round / 5          "
    echo -e "==================================="
    echo -e "\033[1mVous avez 120 secondes.\033[0m"
    echo ">> Chattez librement ou tapez 'coop' ou 'betray' :"
    
    rm -f /tmp/pdgame_local_choice /tmp/pdgame_remote_chose /tmp/pdgame_remote_choice
    
    START_TIME=$SECONDS
    ROUND_OVER=0
    N90=0; N60=0; N30=0; N10=0
    
    # L'EVENT LOOP BASH : tourne chaque seconde
    while [[ $ROUND_OVER -eq 0 ]]; do
        
        # --- GESTION DU TEMPS INTÉGRÉE ---
        ELAPSED=$(( SECONDS - START_TIME ))
        REMAINING=$(( 120 - ELAPSED ))
        
        if [[ $REMAINING -le 90 && $N90 -eq 0 ]]; then echo -e "\r\033[K \033[33mRappel : Il reste 90 secondes.\033[0m"; N90=1; fi
        if [[ $REMAINING -le 60 && $N60 -eq 0 ]]; then echo -e "\r\033[K \033[33mRappel : Il reste 60 secondes.\033[0m"; N60=1; fi
        if [[ $REMAINING -le 30 && $N30 -eq 0 ]]; then echo -e "\r\033[K \033[31mRappel : Il reste 30 secondes !\033[0m"; N30=1; fi
        if [[ $REMAINING -le 10 && $REMAINING -gt 0 && $N10 -ne $REMAINING ]]; then 
            echo -e "\r\033[K\033[31m$REMAINING...\033[0m"; N10=$REMAINING
        fi
        
        if [[ $REMAINING -le 0 ]]; then
            ROUND_OVER=1
            break
        fi

        # --- VÉRIFICATION DES CHOIX ---
        if [[ -f /tmp/pdgame_local_choice && -f /tmp/pdgame_remote_chose ]]; then
            echo -e "\r\033[K\033[32m[Système] Les deux joueurs sont prêts !\033[0m"
            ROUND_OVER=1
            break
        fi

        # --- GESTION DU CLAVIER (NON BLOQUANTE : timeout de 1s) ---
        if read -t 1 -r line; then
            cmd_check=$(echo "$line" | tr -d " \r" | tr '[:upper:]' '[:lower:]')
            
            if [[ "$cmd_check" == "coop" || "$cmd_check" == "betray" ]]; then
                if [[ ! -f /tmp/pdgame_local_choice ]]; then
                    echo "$cmd_check" > /tmp/pdgame_local_choice
                    echo "CMD:CHOSE" >&3
                    echo -e "\033[1A\033[K\033[32m[Système] Votre choix ('$cmd_check') est verrouillé\033[0m"
                else
                    echo -e "\033[1A\033[K\033[31m[Système] Vous avez déjà fait votre choix.\033[0m"
                fi
            elif [[ -n "$cmd_check" ]]; then
                clean_line=$(echo "$line" | tr -d "\r")
                echo "MSG:$clean_line" >&3
                echo -e "\033[1A\033[K\033[35m[Vous]\033[0m : $clean_line"
            fi
        fi
    done

    echo -e "\n\033[33m[Système] Fin de la manche. Échange sécurisé des clés...\033[0m"
    
    if [[ ! -f /tmp/pdgame_local_choice ]]; then
        echo "betray" > /tmp/pdgame_local_choice
        echo -e "\033[31m[Système] Temps écoulé ! Choix par défaut : betray\033[0m"
        echo "CMD:CHOSE" >&3
    fi
    
    my_choice=$(cat /tmp/pdgame_local_choice)
    echo "CMD:CHOICE:$my_choice" >&3
    
    while [[ ! -f /tmp/pdgame_remote_choice ]]; do sleep 0.1; done
    their_choice=$(cat /tmp/pdgame_remote_choice)
    
    HISTORY_ME[$round]=$my_choice
    HISTORY_THEM[$round]=$their_choice
    
    echo -e "\033[32m[Système] Données chiffrées. Motus et bouche cousue ! \033[0m"
    sleep 2
done

# ==========================================
# 6. RÉVÉLATION FINALE
# ==========================================
echo -e "\n\n==================================="
echo -e "      RÉVÉLATION DES RÉSULTATS     "
echo -e "==================================="
sleep 2

SCORE_ME=0
SCORE_THEM=0

for round in {1..5}; do
    m=${HISTORY_ME[$round]}
    t=${HISTORY_THEM[$round]}
    
    echo -e "\n--- MANCHE $round ---"
    echo "Vous: $m | Adversaire: $t"
    
    if [[ "$m" == "coop" && "$t" == "coop" ]]; then
        ((SCORE_ME+=3)); ((SCORE_THEM+=3))
        echo "Coopération mutuelle (+3 chacun)"
    elif [[ "$m" == "betray" && "$t" == "betray" ]]; then
        ((SCORE_ME+=1)); ((SCORE_THEM+=1))
        echo "Trahison mutuelle (+1 chacun)"
    elif [[ "$m" == "betray" && "$t" == "coop" ]]; then
        ((SCORE_ME+=5)); ((SCORE_THEM+=0))
        echo "Coup de maître ! (+5 pour vous)"
    elif [[ "$m" == "coop" && "$t" == "betray" ]]; then
        ((SCORE_ME+=0)); ((SCORE_THEM+=5))
        echo "Vous avez été trahi... (+5 pour l'adversaire)"
    fi
    sleep 2
done

# ==========================================
# 7. FIN DE PARTIE
# ==========================================
echo -e "\n==================================="
echo -e "           SCORE FINAL             "
echo -e "==================================="
echo "Vous : $SCORE_ME | Adversaire : $SCORE_THEM"
if [[ $SCORE_ME -gt $SCORE_THEM ]]; then echo -e "\033[32m FÉLICITATIONS, VOUS AVEZ GAGNÉ !\033[0m"
elif [[ $SCORE_ME -lt $SCORE_THEM ]]; then echo -e "\033[31m DOMMAGE, VOUS AVEZ PERDU !\033[0m"
else echo -e "\033[33m⚖️ ÉGALITÉ PARFAITE !\033[0m"; fi