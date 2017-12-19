#!/bin/bash
# Copyright: NCBI 2017
# Author: Sean La

set -e

if [ "$#" -ne 2 ]; then
	echo "Description: Retrieves accessions numbers for integenic SNPs from GWAS catalog"
	BASENAME=`basename $0`
	echo "Usage: ${BASENAME} [output path for SNP accession file] [directory to store temp files]"
	exit 0
fi

SNPS=$1
OUTPUT_DIR=$2

# Download the GWAS catalog from EBI
ASSOCIATIONS=${OUTPUT_DIR}/gwas_associations.tsv
if [ ! -f ${ASSOCIATIONS} ]; then
	wget -P ${OUTPUT_DIR} https://www.ebi.ac.uk/gwas/api/search/downloads/full
	mv ${OUTPUT_DIR}/full ${ASSOCIATIONS}
fi

# Extract the accessions of all SNPs (currently with accession starting with 'rs') that are marked as integenic
# and output them into a text file.
if [ ! -f ${SNPS} ]; then
	awk -F'\t' '{ if ($26=='1') {print $22} }' ${ASSOCIATIONS} | grep -o "rs[0-9]*" > ${SNPS}
fi
