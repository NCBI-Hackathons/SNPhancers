#!/bin/bash

if [ "$#" -ne 4 ]; then
	echo "$0 [input accessions] [output path] [email address]"
	exit 0
fi

INPUT=$1
OUTPUT=$2
EMAIL=$3

echo "" > ${OUTPUT}

for ACC in $(cat ${INPUT})
do
	efetch -db nuccore -id ${ACC} -format fasta >> ${OUTPUT}
done

echo "" | mail -s "Creation of enhancer region fasta complete" ${EMAIL}
