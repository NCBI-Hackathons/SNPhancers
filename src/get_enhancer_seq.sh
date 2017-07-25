#!/bin/bash
set -e

if [ "$#" -ne 2 ]; then
	echo "Description: Retrieves enhancer regions from RefSeq and returns them in FASTA format."
	BASENAME=`basename $0`
	echo "Usage: ${BASENAME} [input accessions] [output path]"
	exit 0
fi

INPUT=$1
OUTPUT=$2
EMAIL=$3

echo "" > ${OUTPUT}

for ACC in $(cat ${INPUT});do
	efetch -db nuccore -id ${ACC} -format fasta >> ${OUTPUT}
done
