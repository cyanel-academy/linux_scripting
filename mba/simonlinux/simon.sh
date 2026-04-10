#!/bin/bash
SEQUENCE=""
SCORE=0
SCORE_FILE="highscores.txt"
read -p " Entrer votre nom : "  USERNAME
touch "$SCORE_FILE"
while true; do 
INDEX=$((RANDOM % 4))
case $INDEX in
0) NOUVELLE_LETTRE="Q" ;;
1) NOUVELLE_LETTRE="S" ;;
2) NOUVELLE_LETTRE="D" ;;
3) NOUVELLE_LETTRE="F" ;;
esac
SEQUENCE="$SEQUENCE$NOUVELLE_LETTRE"
echo "Memorisez : $SEQUENCE"
sleep 2
clear
read -p "Répétez la séquence : " REPONSE
REPONSE=$(echo "$REPONSE" | tr '[:lower:]' '[:upper:]')
if [ "$REPONSE" == "$SEQUENCE" ]; then
SCORE=$((SCORE + 1))
echo "Bravo ! Score actuel : $SCORE"
sleep 1
clear
else
echo "DOMMAGE !*SLAP* :)"
echo "votre score final : $SCORE"
break
fi
done
echo "$USERNAME $SCORE" >> "$SCORE_FILE"
sort -rn -k2 "$SCORE_FILE" | head -n 10 > temp_scores && mv temp_scores "$SCORE_FILE"
echo ""
echo "--- TOP 10 HIGH SCORES ---"
cat "$SCORE_FILE"
