#!/bin/sh


if [ -z "$3" ];then
      echo "Veuillez préciser un fichier texte en entrée"
      exit 1
elif [ -f "$3" ];then
      echo "Sauvegarde réussie"
      exit 1
fi


echo "$1  $2" > $3

exit 0

