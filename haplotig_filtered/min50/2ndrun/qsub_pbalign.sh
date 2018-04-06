#!/bin/bash
#$ -N pbalnqm4x50
#$ -t 1-41
#$ -pe openmp 8
#$ -R Y
#$ -q free72i,free88i,epyc,bsg,bio,pub8i,free32i,pub64,abio

module load smrtanalysis

REFERENCE="chardonnay_quiv1x_quiv2x_qm3x_fu_qm2xfu_pilon_50000_0.9to1.1_0.9999.fasta"
JOBFILE="myjoblist.txt"
SEED=$(cat $JOBFILE | head -n $SGE_TASK_ID | tail -n 1)

pbalign --nproc 8 input_${SEED}.fofn ${REFERENCE} out_${SEED}.cmp.h5 --forQuiver
#qsub qsub_cmph_merge.sh
