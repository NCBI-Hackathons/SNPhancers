#!/bin/bash

set -e

if [ "$#" -ne 3 ]; then
	echo "Description: Creates a BLAST database given a FASTA file in a specific directory"
	BASENAME=`basename "$0"`
	echo "${BASENAME} [input FASTA] [DB name] [directory]"
	exit 0
fi

INPUT=$1
DBNAME=$2
DIR=$3

cd ${DIR}
makeblastdb -dbtype nucl -in ${INPUT} -out ${DBNAME}
