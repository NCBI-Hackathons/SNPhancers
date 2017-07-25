#!/bin/bash

set -e

if [ "$#" -ne 3 ]; then
	echo "Description: Determines the sets of GWAS intergenic SNPs that are contained in known enhancer regions."
	BASENAME=`basename $0`
	echo "Usage: ${BASENAME} [output directory] [threads]"
	exit 0
fi

DIR=$1
THREADS=$2

SRC=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/src # the location of the `src` directory in the repo

## Get the accessions of GWAS intergenic SNPs
SNP_ACC=${DIR}/snp_acc.txt
${SRC}/get_gwas_snp_accessions.sh ${SNP_ACC} ${DIR} 

## Get the accessions of RefSeq enhancers  
ENHANCER_ACC=${DIR}/enhancer_acc.txt
${SRC}/get_enhancer_accessions.sh ${ENHANCER_ACC}

## Create enhancer FASTA file
ENHANCER_FASTA=${DIR}/enhancer.fasta
${SRC}/get_enhancer_seq.sh ${ENHANCER_ACC} ${ENHANCER_FASTA}

## Create SNP flanking sequence FASTA file
SNP_FLANKS=${DIR}/snps_flanks.fasta
${SRC}/find_snp_sequences.sh ${SNP_ACC} ${SNP_FLANKS}

## Construct a BLAST database out of the SNP sequences
${SRC}/makeblastdb.sh ${ENHANCER_FASTA} enhancer ${DIR}

## Align SNP flanking sequences with enhancer regions a la Magic-BLAST
MBO=${DIR}/snp_flanks_onto_enhancers.mbo
${SRC}/magicblast.sh ${SNP_FLANKS} ${DIR} enhancer ${MBO} ${THREADS}

## Determine the sets of SNPs contained in enhancer regions
TSV=${DIR}/snp_flanks_onto_enhancers.tsv
${SRC}/analyze_gwas.py -f ${ENHANCER_FASTA} -m ${MBO} -o ${TSV} 

echo "Analysis of GWAS enhancers and intergenic SNPs complete."
echo "You can find the TSV file describing the sets of SNPs contained in the enhancer regions in the following file:"
echo ${TSV}
