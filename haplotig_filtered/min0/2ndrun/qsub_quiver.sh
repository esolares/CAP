#!/bin/bash
#$ -N quivqm4x50
### -t 1-17
#$ -pe openmp 32-128
#$ -R Y
#$ -q free72i,free88i,epyc,bsg,bio,free32i,pub64,abio

module load smrtanalysis

QUERY="out_all.cmp.h5"
REFERENCE="chardonnay_quiv1x_quiv2x_qm3x_fu_qm2xfu_pilon_0_0.8to1.2_0.9999.fasta"

samtools faidx ${REFERENCE}
quiver -j ${NSLOTS} ${QUERY} -r ${REFERENCE} -o variants.gff -o consensus.fasta -o consensus.fastq
