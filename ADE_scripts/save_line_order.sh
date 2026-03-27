#!/bin/sh

# FOR PRACTICE 5 :
#if [ "$#" -ne 3 ]; then 
#	echo "Wrong number of parameters. Usage ./save_line_order_improved.sh [product] [price] [file]"
#	echo "Wrong number of parameters" > err.log
#	exit 1
#fi

while [ $# -gt 0 ]; do # tant qu'il y a des arguments
	case "$1" in
		-n)
		name="$2"
		shift 2
		;;
		-p)
		price="$2"
		shift 2
		;;
		-f)
		file_name="$2"
		shift 2
		;;
		*) # all other cases
		echo "Invalid option \"$1\" !";
		echo "Invalid option" > err.log
		exit 1
		;;
	esac
done


if ! echo $price | grep -Eq "^[0-9]+([.][0-9]+)?$"; then #si le prix n'est pas un entier
	echo "Invalid price $price, must be a number"
	echo "Price is not a number" > err.log
	exit 1
fi

line="$name $price"

#if [ -f $file_name ]; then #si le fichier existe
#	echo $line >> $file_name #on ajoute à la nouvelle ligne, sans écraser
#	exit 0
#else 
#	echo $line > $file_name #on crée le fichier avec la commande
#	exit 0
#fi

# ne sert à rien de faire ce que j'ai fait au-dessus, on peut faire direct ça :

echo $line >> $file_name
# soit ca cree le fichier si il n'existe pas, soit ca complete

echo "Order insterted."
exit 0