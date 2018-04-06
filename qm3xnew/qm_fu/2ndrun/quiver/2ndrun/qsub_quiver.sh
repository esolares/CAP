#!/bin/bash
#$ -N quiver
### -t 1-17
#$ -pe openmp 80
#$ -R Y
#$ -q bigmemory,free72i,free88i,bio,abio

module load smrtanalysis

QUERY="out_all.cmp.h5"
REFERENCE="chardonnay_quiv_qm3x_fu_qm2xfu.fasta"

samtools faidx ${REFERENCE}
quiver -j 80 ${QUERY} -r ${REFERENCE} -o variants.gff -o consensus.fasta -o consensus.fastq
