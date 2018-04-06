#!/bin/bash
#$ -N cmphmerge
### -t 1-17
#$ -pe openmp 1
#$ -R Y
#$ -q bio,pub64,pub8i,free32i,free88i,abio,free64

module load smrtanalysis

MYLISTLEN=$(($(ls out_*.h5 | wc -l)-1))
#cmph5tools.py merge --outFile out_all.cmp.h5 $(ls out_{1..${MYLISTLEN}}.cmp.h5)
cmph5tools.py merge --outFile out_all.cmp.h5 $(ls out_{1..41}.cmp.h5)
cmph5tools.py sort --deep out_all.cmp.h5

h5repack -f GZIP=1 out_all.cmp.h5 tmp.cmp.h5 && mv tmp.cmp.h5 out_all.cmp.h5
