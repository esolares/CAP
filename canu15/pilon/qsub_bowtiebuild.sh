#!/bin/bash
#$ -N bt2buildcanu
### -t 1-17
#$ -pe openmp 32-128
#$ -R Y
#$ -q free88i,free72i,epyc,bsg,bigmemory,bio,pub64

#PATH=$PATH:/data/users/solarese/bin/bowtie2
source ~/.miniconda

REF="chardonnay.contigs_quiv2x.fasta"
OPTIONS="--threads $NSLOTS"

bowtie2-build ${OPTIONS} ${REF} $(basename ${REF} .fasta)
qsub qsub_bowtie2.sh
