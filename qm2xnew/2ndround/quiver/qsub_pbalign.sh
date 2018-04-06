#!/bin/bash
#$ -N pbalignqm2x
#$ -t 1-41
#$ -pe openmp 12,16,18
#$ -R Y
#$ -q free72i,free88i,epyc,bio,pub8i,free32i,pub64,abio

module load smrtanalysis

REFERENCE="chardonnay_canu_qmdc.fasta"
JOBFILE="myjoblist.txt"
SEED=$(cat $JOBFILE | head -n $SGE_TASK_ID | tail -n 1)

pbalign --nproc 8 input_${SEED}.fofn ${REFERENCE} out_${SEED}.cmp.h5 --forQuiver
