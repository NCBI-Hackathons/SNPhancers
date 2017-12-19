#!/bin/bash

set -e

if [ "$#" -ne 1 ]; then
	echo "Description: Retrieves accessions for enhancer regulatory regions within the human genome."
	BASENAME=`basename $0`
	echo "Usage: ${BASENAME} [output path]"
	exit 0
fi

OUTPUT=$1

esearch -query 'regulatory enhancer[feature key] AND PRJNA343958[bioproject]' -db nucleotide -source refseq -organism human | esummary | xtract -pattern DocumentSummary -element Caption > ${OUTPUT}
