#!/bin/bash

set -e

if [ "$#" -ne 2 ]; then
	echo "Description: Given a text file containing SNP accessions, creates a FASTA file containing the flanking"
	echo "             sequences for each SNP"
	BASENAME=`basename "$0"`
	echo "Usage: ${BASENAME} [SNP accessions file] [output path]"
	exit 0
fi

SNP_ACC=$1
OUTPUT=$2

echo "" > ${OUTPUT}

for ACC in $(cat ${SNP_ACC})
do
	echo ">${ACC}" >> ${OUTPUT}
	esearch -query ${ACC} -db snp | esummary | xtract -pattern DocumentSummary -element DOCSUM | egrep -o 'SEQ[^|]+' | sort -u | awk -F"SEQ=" '{print $2}' | sed 's/\[//' | sed 's/\/\w\]//' | sed 's/\///g' | sed 's/\]//g' | sed 's/\-//g' >> ${OUTPUT}
done
