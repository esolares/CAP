#!/bin/bash
#$ -N quiver
#$ -pe openmp 32
#$ -R Y
#$ -q bio,abio,free64,free32i

#source ~/.mybashrc

module load smrtanalysis/2.3.0p5
