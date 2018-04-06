#!/bin/bash
#$ -N mumploti1
### -t 1-17
#$ -pe openmp 1
#$ -R Y
#$ -q bio,free88i,free72i,free40i,free32i,abio

#PATH=/data/users/solarese/bin/MUMmer3.23:$PATH
source ~/.qmbashrc
#module load quickmerge/0.0
module load gnuplot/4.6.3

REF="Vitis_vinifera.IGGP_12x.30.dna.genome.fa"
PREFIX="vitis_vinifera"
#REF="Cabernet74SMRTcells_FALCON-unzip_primary.fasta"
#PREFIX="cabernet"

QRY="chardonnay_quiv2x_qm3x_fu_qm2xfu_pilon.fasta"
PREFIX="${PREFIX}_chardonnay_qm3x_quiv2x_pilon"

#perl -pe 's/>[^\$]*$/">chardSeg" . ++$n ."\n"/ge' ${QRY} > $(basename ${QRY} .fasta)_new.fasta

#cat ${REF} | sed -r 's/[/ =.\t]+/_/g' > $(basename ${REF} .fasta)_new.fasta
#cat ${QRY} | sed -r 's/[/ =.\t]+/_/g' > $(basename ${QRY} .fasta)_new.fasta

#REF=$(basename ${REF} .fasta)_new.fasta
QRY=$(basename ${QRY} .fasta)_new.fasta

nucmer -l 100 -c 1000 -d 10 -banded -D 5 -prefix ${PREFIX} ${REF} ${QRY}
#nucmer --maxmatch -prefix ${PREFIX} ../${REF} ../${QRY}

#mummerplot --large --layout -p ${PREFIX} ${PREFIX}.delta \
#   -R ${REF} -Q ${QRY} --png 2>> nucmer_error.log

mummerplot --fat --filter -p ${PREFIX} ${PREFIX}.delta \
   -R ${REF} -Q ${QRY} --postscript
#--postscript
#--png
