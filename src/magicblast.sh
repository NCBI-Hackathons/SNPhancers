#!/bin/bash

set -e

if [ "$#" -ne 5 ]; then
	echo "$0 [query file] [database directory] [database name] [output path] [email address]"
	exit 0
fi

QUERY=$1
DBDIR=$2
DBNAME=$3
OUTPUT=$4
EMAIL=$5

export BLASTDB=${DBDIR}
magicblast -query ${QUERY} -db ${DBNAME} -outfmt tabular -out ${OUTPUT}
echo "" | mail -s "Finished running Magic-BLAST on enhancer regions and intergenic SNPs" ${EMAIL}
