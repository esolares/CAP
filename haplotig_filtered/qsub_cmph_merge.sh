#!/bin/bash
#$ -N cmphmergeqm3x
### -t 1-17
#$ -pe openmp 1
#$ -R Y
#$ -q free72i,free88i,epyc,bio,pub8i,free32i,pub64,abio

module load smrtanalysis

cmph5tools.py merge --outFile out_all.cmp.h5 $(ls out_{1..41}.cmp.h5)

cmph5tools.py sort --deep out_all.cmp.h5

h5repack -f GZIP=1 out_all.cmp.h5 tmp.cmp.h5 && mv tmp.cmp.h5 out_all.cmp.h5
qsub qsub_quiver.sh
