#!/bin/bash

if [ -z "$1" ]; then
	echo "Passer le nom de la copie comme parametre du script SVP"
else
touch tmp
touch tmp0
touch final

#Diviser le fichier par ligne en supprimant les ; et \s
sed -i 's/;/\n/g' $1
sed -i 's/ //g' $1

#Récuupérer que les champs qui nous interessent: MAC + erreurs
cut -d',' -f2,3,4,5,10,11 $1 > tmp

#Supprimer les lignes dont on a pas besoin
sed -i '/89$/d' tmp

#Trier le fichier par MAC
cat tmp | sort -k1n >> tmp0
cat tmp0 > tmp

#supprimer les lignes vides et retourner les lignes uniques
sed -i '/^$/d' tmp
cat tmp | sort -u > tmp0

#calculer les doublons et les supprimer après
cat tmp | sort | uniq -c > final

#supprimer les espaces de départ
sed -i 's/^\ *//g' final

#remplacer l'espace restant par ,
sed -i 's/ /,/g' final

ctr=$(cat final | wc -l)
truncate -s 0 tmp

for ((i=1; i<=$ctr; i++))
	do
	MAC=$(cat final | head -$i | tail -1 | cut -d',' -f2)
	ERR=$(cat final | head -$i | tail -1 | awk -F"," '{print $NF}')
	CTR=$(cat final | head -$i | tail -1 | cut -d',' -f1)
	echo "'$MAC': '$ERR' : $CTR," >> tmp
	done

truncate -s 0 final
truncate -s 0 tmp0

cat tmp | cut -d':' -f1 | sort -u > tmp0
ctr0=$(cat tmp0 | wc -l)
ctr=$(cat tmp | wc -l)

for ((i=1; i<=$ctr0; i++))
	do
	MAC=$(cat tmp0 | head -$i | tail -1)
	for ((j=1; j<=$ctr; j++ ))
		do
		f23=$(cat tmp | grep $MAC | cut -d':' -f2,3 | tr '\n' ' ')
		done
		echo "$MAC$f23" >> final
	done

rm $1 tmp*

sed -i 's/, $//g' final

mv final result

fi
