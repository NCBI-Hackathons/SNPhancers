#!/bin/bash

set -e

if [ "$#" -ne 5 ]; then
	echo "Description: Runs Magic-BLAST given a query FASTA file and BLAST database"
	BASENAME=`basename $0`
	echo "Usage: ${BASENAME} [query file] [database directory] [database name] [output path] [threads]"
	exit 0
fi

QUERY=$1
DBDIR=$2
DBNAME=$3
OUTPUT=$4
THREADS=$5

export BLASTDB=${DBDIR}
magicblast -query ${QUERY} -db ${DBNAME} -outfmt tabular -out ${OUTPUT} -num_threads ${THREADS}
