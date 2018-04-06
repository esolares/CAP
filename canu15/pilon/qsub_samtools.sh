#!/bin/bash
#$ -N samtoolscanu
### -t 1-17
#$ -pe openmp 32-128
#$ -R Y
#$ -q free88i,free72i,epyc,bsg,bigmemory,bio,pub64,abio

module load samtools/1.3

REF="chardonnay.contigs_quiv2x.fasta"
PREFIX="chardonnay_illumPE150"
QRY="${PREFIX}_$(basename ${REF} .fasta).sam"

OPTIONS="--threads $NSLOTS"

samtools view ${OPTIONS} -b ${QRY} --reference ${REF} -o $(basename ${QRY} .sam).bam
samtools sort ${OPTIONS} $(basename ${QRY} .sam).bam -o $(basename ${QRY} .sam)_sorted.bam
samtools index -b $(basename ${QRY} .sam)_sorted.bam $(basename ${QRY} .sam)_sorted.bai
qsub qsub_pilon.sh
