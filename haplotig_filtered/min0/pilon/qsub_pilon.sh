#!/bin/bash
#$ -N pilonqm4x08
### -t 1-17
#$ -pe openmp 32-80
#$ -R Y
#$ -q bigmemory
####bio,pub64,free88i,abio,free64

module purge
source ~/.miniconda
#module load jje/pilon
#PATH=$PATH:/data/users/solarese/bin/bowtie2

REF="chardonnay_quiv2x_quiv2x_qm3x_fu_qm2xfu_pilon_0_0.8to1.2_0.9999.fasta"
PREFIX="chardonnay_illumPE150"
QRY="${PREFIX}_$(basename ${REF} .fasta)_sorted.bam"

OPTIONS="--vcf --tracks --threads $NSLOTS"

#do an if statement
#samtools faidx ${REF}
pilon ${OPTIONS} --genome ${REF} --frags ${QRY} --output $(basename ${REF} .fasta)_pilon
