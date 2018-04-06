#!/bin/bash
#$ -N quiverqm3x
### -t 1-17
#$ -pe openmp 32-128
#$ -R Y
#$ -q free72i,free88i,epyc,bio,free32i,pub64,abio

module load smrtanalysis

QUERY="out_all.cmp.h5"
REFERENCE="chardonnay_qmqmcqmdcfu.fasta"

samtools faidx ${REFERENCE}
quiver -j ${NSLOTS} ${QUERY} -r ${REFERENCE} -o variants.gff -o consensus.fasta -o consensus.fastq
