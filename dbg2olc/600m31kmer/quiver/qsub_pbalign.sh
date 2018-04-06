#!/bin/bash
#$ -N pbalign
#$ -t 1-41
#$ -pe openmp 8
#$ -R Y
#$ -q free72i,free88i,epyc,bio,pub8i,free32i,pub64,abio

module load smrtanalysis

REFERENCE="chardonnay_30x_LD0_K31_KCOV_ADAPT0.01_MINOVL30_RMCHIM1_asm.fasta"
JOBFILE="myjoblist.txt"
SEED=$(cat $JOBFILE | head -n $SGE_TASK_ID | tail -n 1)

pbalign --nproc 8 input_${SEED}.fofn ${REFERENCE} out_${SEED}.cmp.h5 --forQuiver
#qsub qsub_cmph_merge.sh
