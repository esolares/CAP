#!/bin/bash
#$ -N chquast
#$ -q bio,abio
#$ -pe openmp 1

source ~/.mybashrc

quast.py chardonnay-auto-sge/chardonnay.unitigs.fasta
