#!/bin/bash
#$ -N pilon
### -t 1-17
#$ -pe openmp 79
#$ -R Y
#$ -q bigmemory
####bio,pub64,free88i,abio,free64

module purge
source ~/.miniconda
#module load jje/pilon
#PATH=$PATH:/data/users/solarese/bin/bowtie2

REF="chardonnay_quiv2x_qm3x_fu_qm2xfu.fasta"
PREFIX="chardonnay_illumPE150"
QRY="${PREFIX}_$(basename ${REF} .fasta)_sorted.bam"

OPTIONS="--vcf --tracks --threads 79"

#do an if statement
#samtools faidx ${REF}
pilon ${OPTIONS} --genome ${REF} --frags ${QRY} --output $(basename ${REF} .fasta)_pilon
