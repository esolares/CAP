#!/bin/bash
#$ -N bt2build
### -t 1-17
#$ -pe openmp 64
#$ -R Y
#$ -q bigmemory,free88i,free72i,bio,pub64

#PATH=$PATH:/data/users/solarese/bin/bowtie2
source ~/.miniconda

REF="chardonnay_quiv2x_qm3x_fu_qm2xfu.fasta"
OPTIONS="--threads 64"

bowtie2-build ${OPTIONS} ${REF} $(basename ${REF} .fasta)
qsub qsub_bowtie2.sh
