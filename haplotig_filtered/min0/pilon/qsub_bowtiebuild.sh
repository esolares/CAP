#!/bin/bash
#$ -N bt2buildqm4x08
### -t 1-17
#$ -pe openmp 32-128
#$ -R Y
#$ -q bigmemory,free88i,free72i,epyc,bsg,bio,free32i,pub64

#PATH=$PATH:/data/users/solarese/bin/bowtie2
source ~/.miniconda

REF="chardonnay_quiv2x_quiv2x_qm3x_fu_qm2xfu_pilon_0_0.8to1.2_0.9999.fasta"
OPTIONS="--threads $NSLOTS"

bowtie2-build ${OPTIONS} ${REF} $(basename ${REF} .fasta)
qsub qsub_bowtie2.sh
