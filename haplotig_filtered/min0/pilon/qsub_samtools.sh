#!/bin/bash
#$ -N samtoolqm4x08
### -t 1-17
#$ -pe openmp 32-128
#$ -R Y
#$ -q bigmemory,free88i,free72i,epyc,bsg,bio,pub64,abio

module load samtools/1.3

REF="chardonnay_quiv2x_quiv2x_qm3x_fu_qm2xfu_pilon_0_0.8to1.2_0.9999.fasta"
PREFIX="chardonnay_illumPE150"
QRY="${PREFIX}_$(basename ${REF} .fasta).sam"

OPTIONS="--threads $NSLOTS"

samtools view ${OPTIONS} -b ${QRY} --reference ${REF} -o $(basename ${QRY} .sam).bam
samtools sort ${OPTIONS} $(basename ${QRY} .sam).bam -o $(basename ${QRY} .sam)_sorted.bam
samtools index -b $(basename ${QRY} .sam)_sorted.bam $(basename ${QRY} .sam)_sorted.bai
qsub qsub_pilon.sh
