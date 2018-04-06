#!/bin/bash
#
#$ -N Edwin_Job
#$ -t 1-7
#$ -q abio,bio, free64,pub64
### -m beas
### -M solarese@uci.edu
### -o
### -e
#$ -pe openmp 1   ##how many parallel environments to run and in what env i.e. openmp or mpi

JOBFILE="mylist.txt"
SEED=$(cat $JOBFILE | head -n $SGE_TASK_ID | tail -n 1)

echo "${SEED} is dope"

