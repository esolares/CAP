#!/bin/bash
#$ -N pbalign
#$ -t 1-41
#$ -pe openmp 8
#$ -R Y
#$ -q bio,pub64,pub8i,free32i,free88i,abio,free64

module load smrtanalysis

REFERENCE="chardonnay_quiv_qm3x_fu_qm2xfu.fasta"
JOBFILE="myjoblist.txt"
SEED=$(cat $JOBFILE | head -n $SGE_TASK_ID | tail -n 1)

pbalign --nproc 8 input_${SEED}.fofn ${REFERENCE} out_${SEED}.cmp.h5 --forQuiver
