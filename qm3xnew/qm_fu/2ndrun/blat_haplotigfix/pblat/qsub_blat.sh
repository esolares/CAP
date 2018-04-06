#!/bin/bash
#$ -N pblatchar
### -t 1-17
#$ -pe openmp 37
#$ -R Y
#$ -q bsg 
#####bio,free88i,free72i,abio

#module load blat/36
PATH=/data/users/solarese/bin/pblat:$PATH

QRY="chardonnay_quiv2x_qm3x_fu_qm2xfu_pilon.fasta"
REF="chardonnay_quiv2x_qm3x_fu_qm2xfu_pilon_ref.fasta"
OUTPUT="chard_self_aln.psl"
#OPTIONS="-ooc=11.ooc -fastMap"
#OPTIONS="-makeOoc=11.ooc -fastMap"
#OPTIONS="-makeOoc=11.ooc -ooc=11.ooc -fastMap"
OPTIONS="-threads=37"

pblat ${REF} ${QRY} ${OPTIONS} ${OUTPUT}
