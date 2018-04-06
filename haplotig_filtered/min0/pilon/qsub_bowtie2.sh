#!/bin/bash
#$ -N bt2qm4x08
### -t 1-17
#$ -pe openmp 32-128
#$ -R Y
#$ -q bigmemory,free88i,free72i,epyc,bsg,bio,pub64,abio

#PATH=$PATH:/data/users/solarese/bin/bowtie2
source ~/.miniconda

QRY1="chardonnay_illumpe150_R1.fastq"
QRY2="chardonnay_illumpe150_R2.fastq"
REF="chardonnay_quiv2x_quiv2x_qm3x_fu_qm2xfu_pilon_0_0.8to1.2_0.9999.fasta"
PREFIX="chardonnay_illumPE150"
OPTIONS="--threads $NSLOTS"

bowtie2 $OPTIONS -x $(basename ${REF} .fasta) -1 ${QRY1} -2 ${QRY2} -S ${PREFIX}_$(basename ${REF} .fasta).sam
qsub qsub_samtools.sh
