#!/bin/bash
#$ -N quastchard600
### -t 1-17
#$ -pe openmp 16
#$ -R Y
#$ -q bigmemory,bio,free88i,free72i,pub64,abio,free64

source ~/.mybashrc
quast.py -m 1000 -t 16 *Primary.fasta *qmdc.fasta merged.fasta
