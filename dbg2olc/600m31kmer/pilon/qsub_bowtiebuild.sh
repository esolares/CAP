#!/bin/bash
#$ -N bt2builddbg
### -t 1-17
#$ -pe openmp 32-128
#$ -R Y
#$ -q free88i,free72i,epyc,bsg,bigmemory,bio,pub64

#PATH=$PATH:/data/users/solarese/bin/bowtie2
source ~/.miniconda

REF="chardonnay_30x_LD0_K31_KCOV_ADAPT0.01_MINOVL30_RMCHIM1_asm.fasta"
OPTIONS="--threads $NSLOTS"

bowtie2-build ${OPTIONS} ${REF} $(basename ${REF} .fasta)
qsub qsub_bowtie2.sh
