# SNPhancers

## Overview: 

SNPhancers `determines the relationships between intergenic SNPs` (which are discovered through genome wide association studies) and known enhancer regions in the human genome.

## Usage:

1. Retrieves the accessions of GWAS intergenic SNPs.

2. Retrieves the accessions of enhancer regions of the human genome from RefSeq.

3. Creates a FASTA of the intergenic SNPs.

4. Creates a FASTA file out of the enhancer regions.

5. Constructs a BLAST database out of the SNP flanking sequences.

6. Aligns the enhancer regions onto the SNP flanking sequences using Magic-BLAST.

7. Determines which SNPs are contained in each enhancer region. 
