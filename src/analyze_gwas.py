#!/usr/bin/env python
# Copyright: NCBI 2017
# Author: Sean La

import getopt
import sys

def get_accessions(fasta_path):
	accessions = {}
	with open(fasta_path,'r') as fasta:
		id_number = 0
		for line in fasta:
			if line[0] == ">":
				accession = line[1:].rstrip()
				accessions[str(id_number)] = accession 
				id_number += 1
	return accessions	

def get_alignments(mbo_path):
	alignments = {}
	with open(mbo_path,'r') as mbo:
		for line in mbo:
			tokens = line.split('	')
			if line[0] != '#' and len(tokens) == 25:
				enhancer = tokens[0]
				variant = tokens[1]
				if variant != '-':
					if enhancer not in alignments:
						alignments[enhancer] = []
					if variant not in alignments[enhancer]:
						alignments[enhancer].append(variant)	 
	return alignments

def translate_accessions(alignments,accessions):
	translated_alignments = {}
	for enhancer in alignments:
		translated_alignments[enhancer] = [ accessions[id_number] for id_number in alignments[enhancer] ]
	return translated_alignments

def create_tsv(alignments,output_path):
	with open(output_path,'w') as output:
		output.write('Enhancer	Intergenic SNPs\n')
		for enhancer in alignments:
			line = "%s" %(enhancer)
			for snp in alignments[enhancer]:
				line = "%s	%s" % (line,snp)
			output.write(line)
			output.write('\n')

if "__name__" == __main__:
help_message = ""
usage_message = "[-h help and usage] [-f path to FASTA file containing BLASTDB seq] [-m path to MBO file] "\
              + "[-o output path for TSV]"

options = "hm:f:o:"

try:
	opts, args = getopt.getopt(sys.argv[1:], options)
except getopt.GetoptError:
	print("Error: unable to read command line arguments.")
	sys.exit(2)

if len(sys.argv) == 1:
	print(usage_message)
	sys.exit()

mbo_path = None
fasta_path = None
output_path = None

for opt, arg in opts:
	if opt == '-h':
		print(help_message)
		print(usage_message)
		sys.exit(0)
	elif opt == '-m':
		mbo_path = arg
	elif opt == '-f':
		fasta_path = arg	
	elif opt == '-o':
		output_path = arg

opts_incomplete = False

if mbo_path == None:
	opts_incomplete = True
	print("Error: please provide the path to the Magic-BLAST tabulated output file.")
if fasta_path == None:
	opts_incomplete = True
	print("Error: please provide the path to the FASTA file used as reference for the BLAST database.")
if output_path == None:
	opts_incomplete = True
	print("Error: please provide a path for the output TSV file.")
if opts_incomplete:
	print(usage_message)
	sys.exit(1)

alignments = get_alignments(mbo_path)
accessions = get_accessions(fasta_path)
translated_alignments = translate_accessions(alignments,accessions)
create_tsv(translated_alignments,output_path)
