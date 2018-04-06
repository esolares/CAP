#!/bin/bash
#$ -N quastcanuserial
### -t 1-17
#$ -pe openmp 8
#$ -R Y
#$ -q bigmemory,bio,free88i,free72i,pub64,abio,free64,pub8i

source ~/.miniconda
quast.py -m 1000 -t 8 chardonnay_quiv2x_qm3x_fu_qm2xfu_pilon.fasta chardonnay_qm3x_fu_qm2xfu.fasta Cabernet74SMRTcells_FALCON-unzip_primary.fasta
