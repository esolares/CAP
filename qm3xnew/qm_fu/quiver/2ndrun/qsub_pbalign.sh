#!/bin/bash
#$ -N pbalignqm3x
#$ -t 1-41
#$ -pe openmp 8
#$ -R Y
#$ -q free72i,free88i,epyc,bsg,bio,pub8i,free32i,pub64,abio

module load smrtanalysis

REFERENCE="chardonnay_quiv1x_qmqmcqmdcfu.fasta"
JOBFILE="myjoblist.txt"
SEED=$(cat $JOBFILE | head -n $SGE_TASK_ID | tail -n 1)

pbalign --nproc 8 input_${SEED}.fofn ${REFERENCE} out_${SEED}.cmp.h5 --forQuiver
#qsub qsub_cmph_merge.sh
