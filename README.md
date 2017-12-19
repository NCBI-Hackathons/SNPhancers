## Overview

SNPhancers determines the presence of intergenic SNPs in known enhancer regions of the human genome.
The steps that it performs are:

1. Retrieves the accessions of GWAS intergenic SNPs.
2. Retrieves the accessions of enhancer regions of the human genome from RefSeq.
3. Creates a FASTA of the intergenic SNPs.
4. Creates a FASTA file out of the enhancer regions.
5. Constructs a BLAST database out of the SNP flanking sequences.
6. Aligns the enhancer regions onto the SNP flanking sequences using Magic-BLAST.
7. Determines which SNPs are contained in each enhancer region.
8. Outputs a TSV file describing the SNPs that are likely contained in each enhancer region.

## Installation

1. Install the following:
* [NCBI EDirect](http://bioinformatics.cvr.ac.uk/blog/ncbi-entrez-direct-unix-e-utilities/)
* [Magic-BLAST](https://ncbiinsights.ncbi.nlm.nih.gov/tag/magic-blast/)
* Python 2.7.2+
2. Add the directories containing the Edirect tools as well as the `magicblast` and `makeblastdb` binaries to your `PATH` environment variable (ideally in your `.profile` or `.bashrc` file).
3. Add the SNPhancers repository directory to your `PATH` variable.

## Usage
Running `snphancers ${PWD} 4` will run the pipeline in the current directory, using 4 threads from the local machine.
