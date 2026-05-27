#!/bin/sh

input() {
    echo "$1" >&2
    read response
    echo "$response"
}

lettre_aleatoire() {
    nombre=$((RANDOM % 4))
    if [ "$nombre" = "0" ]; then
        echo "q"
    elif [ "$nombre" = "1" ]; then
        echo "s"
    elif [ "$nombre" = "2" ]; then
        echo "d"
    else
        echo "f"
    fi
}


pseudo=$(input "Entrez votre nom :")
score=0
sequence=""


continuer="oui"
while [ "$continuer" = "oui" ]; do

    nouvelle_lettre=$(lettre_aleatoire)

    if [ -z "$sequence" ]; then
        sequence="$nouvelle_lettre"
    else
        sequence="$sequence $nouvelle_lettre"
    fi

    # Afficher la séquence
    echo "---------------------------"
    echo "Séquence : $sequence"
    echo "---------------------------"
    sleep 2
    clear

    reponse=$(input "$pseudo, répète la séquence :")

    if [ "$reponse" != "$sequence" ]; then
        echo "PERDU ! La bonne réponse était : $sequence"
        continuer="non"
    else
        echo "Bien joué !"
        score=$((score + 1))
        sleep 1
        clear
    fi

done

touch scores.txt
printf "%-20s| %d\n" "$(echo "$pseudo" | tr '[:lower:]' '[:upper:]')" "$score" >> scores.txt

echo "================================="
echo "Score : $score"
echo "================================="
echo "--- CLASSEMENT ---"
sort -t"|" -k2 -rn scores.txt | head -n 10
echo "=================================" 