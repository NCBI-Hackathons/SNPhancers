#!/bin/bash

if [ "$#" -ne 4 ]; then
	echo "$0 [input FASTA] [DB name] [directory] [email address]"
	exit 0
fi

INPUT=$1
DBNAME=$2
DIR=$3
EMAIL=$4

cd ${DIR}
makeblastdb -dbtype nucl -in ${INPUT} -out ${DBNAME}
echo "" | mail -s "Creation of BLAST database for ${INPUT} complete" ${EMAIL}
