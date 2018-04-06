#!/bin/bash
#$ -N mumbatch
#$ -t 1-19
#$ -pe openmp 1
#$ -R Y
#$ -q bigmemory,bio,pub64,free88i,abio,free64

#PATH=/data/users/solarese/bin/MUMmer3.23:$PATH
source ~/.qmbashrc
module load gnuplot/4.6.3

REF="dmel-all-chromosome-r6.16.fasta"
PREFIX="flybase"

SEED=$(ls *asm.fasta | head -n $SGE_TASK_ID | tail -n 1)

#quickmerge sequel & qmsp 2nd run
#QRY="iso1_onp_30x100m_LD0_K17_KCOV_ADAPT0.01_MINOVL25_RMCHIM1_asm.fasta"
#PREFIX="${PREFIX}_onp100m_kcov2adapt0.01"
#QRY="iso1_onp_30x130m_LD0_K17_KCOV_ADAPT0.01_MINOVL25_RMCHIM1_asm.fasta"
#PREFIX="${PREFIX}_onp130m_kcov2adapt0.01"
#QRY="iso1_onp_30x100m_LD0_K17_KCOV_ADAPT0.005_MINOVL25_RMCHIM1_asm.fasta"
#PREFIX="${PREFIX}_onp100m_kov4adapt0.005"
#QRY="iso1_onp_30x130m_LD0_K17_KCOV_ADAPT0.005_MINOVL25_RMCHIM1_asm.fasta"
#PREFIX="${PREFIX}_onp130m_kcov4_adapt0.005"
#QRY="iso1_onp_30x130m_LD0_K17_KCOV_ADAPT0.015_MINOVL30_RMCHIM1_asm.fasta"
#PREFIX="${PREFIX}_onp130m_kcov4_adapt0.015_minovl30"

#QRY=$SEED
#PREFIX=${PREFIX}_$(basename ${SEED} _RMCHIM1_asm.fasta)
QRY="chardonnay_quiv2x_qm3x_fu_qm2xfu_pilon.fasta"
PREFIX="${PREFIX}_chardonnay_qm3x_quiv2x_pilon"
echo $SEED
echo $PREFIX



nucmer -l 100 -c 1000 -d 10 -banded -D 5 -prefix ${PREFIX} ${REF} ${QRY}
#nucmer --maxmatch -prefix ${PREFIX} ../${REF} ../${QRY}

#mummerplot --large --layout -p ${PREFIX} ${PREFIX}.delta \
#   -R ${REF} -Q ${QRY} --png 2>> nucmer_error.log

mummerplot --fat --filter -p ${PREFIX} ${PREFIX}.delta \
   -R ${REF} -Q ${QRY} --postscript
#--png
