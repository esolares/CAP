#!/bin/bash
#$ -N bt2
### -t 1-17
#$ -pe openmp 32-128
#$ -R Y
#$ -q free88i,free72i,epyc,bsg,bigmemory,bio,pub64,abio

#PATH=$PATH:/data/users/solarese/bin/bowtie2
source ~/.miniconda

QRY1="chardonnay_illumpe150_R1.fastq"
QRY2="chardonnay_illumpe150_R2.fastq"
REF="chardonnay_qmqm_qmfuqmcqmdc_quiv2x.fasta"
PREFIX="chardonnay_illumPE150"
OPTIONS="--threads $NSLOTS"

bowtie2 $OPTIONS -x $(basename ${REF} .fasta) -1 ${QRY1} -2 ${QRY2} -S ${PREFIX}_$(basename ${REF} .fasta).sam
qsub qsub_samtools.sh
