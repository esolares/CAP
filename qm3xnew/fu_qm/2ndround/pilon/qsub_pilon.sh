#!/bin/bash
#$ -N pilonqm4xf
### -t 1-17
#$ -pe openmp 32-80
#$ -R Y
#$ -q bigmemory
####bio,pub64,free88i,abio,free64

module purge
source ~/.miniconda
#module load jje/pilon
#PATH=$PATH:/data/users/solarese/bin/bowtie2

REF="chardonnay_qmqm_qmfuqmcqmdc_quiv2x.fasta"
PREFIX="chardonnay_illumPE150"
QRY="${PREFIX}_$(basename ${REF} .fasta)_sorted.bam"

OPTIONS="--vcf --tracks --threads $NSLOTS"

#do an if statement
#samtools faidx ${REF}
pilon ${OPTIONS} --genome ${REF} --frags ${QRY} --output $(basename ${REF} .fasta)_pilon
