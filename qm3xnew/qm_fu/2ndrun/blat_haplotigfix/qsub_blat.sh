#!/bin/bash
#$ -N blatchar
### -t 1-17
#$ -pe openmp 1
#$ -R Y
#$ -q bigmemory,bio,free88i,free72i

module load blat/36

QRY="chardonnay_quiv2x_qm3x_fu_qm2xfu_pilon.fasta"
REF="chardonnay_quiv2x_qm3x_fu_qm2xfu_pilon_ref.fasta"
OUTPUT="chard_self_aln.psl"
#OPTIONS="-ooc=11.ooc -fastMap"
#OPTIONS="-makeOoc=11.ooc -fastMap"
#OPTIONS="-makeOoc=11.ooc -ooc=11.ooc -fastMap"
OPTIONS=""

blat ${REF} ${QRY} ${OPTIONS} ${OUTPUT}
