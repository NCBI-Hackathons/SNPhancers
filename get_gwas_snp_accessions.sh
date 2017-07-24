#!/bin/bash

# Download the GWAS catalog
if [ ! -f gwas_associations.tsv ]; then
	wget https://www.ebi.ac.uk/gwas/api/search/downloads/full
	mv full gwas_associations.tsv
fi

# Extract the accessions of all SNPs (currently with accession starting with 'rs') that are marked as integenic
if [ ! -f gwas_snp_accessions.txt ]; then
	awk -F'\t' '{ if ($26=='1') {print $22} }' gwas_associations.tsv | grep -o "rs[0-9]*" > gwas_snp_accessions.txt
fi
