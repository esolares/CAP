#!/bin/bash
#$ -N qmchnew3130
### -t 1-1
#$ -pe openmp 2
#$ -R Y
#$ -q bigmemory,bio,pub64,free88i,free72i,free40i,free32i

source ~/.qmbashrc

#REFERENCE
ref="Chardonnay_Falcon-unzip_Primary.fasta"
#QUERY
qry="chardonnay_qmfuqmcqmdc.fasta"
prefix=${qry/.fasta/}_${ref/.fasta/}_qm
##opt_l is the n50
opt_l="345000"
options="-hco 5.0 -c 1.5 -l $opt_l -ml 20000"

#renames headers
#perl -pe 's/>[^\$]*$/">HSeg" . ++$n ."\n"/ge' ${ASM1} > $(basename ${ASM1} .fasta)_new.fasta
#perl -pe 's/>[^\$]*$/">LSeg" . ++$n ."\n"/ge' ${ASM2} > $(basename ${ASM2} .fasta)_new.fasta

#removes escape chars and spaces
cat ${ref} | sed -r 's/[/ =,\t]+/_/g' > $(basename ${ref} .fasta)_new.fasta
cat ${qry} | sed -r 's/[/ =,\t]+/_/g' > $(basename ${qry} .fasta)_new.fasta
qry=$(basename ${qry} .fasta)_new.fasta
ref=$(basename ${ref} .fasta)_new.fasta

nucmer -l 100 -prefix $prefix $ref $qry
delta-filter -i 95 -r -q $prefix.delta > $prefix.rq.delta
quickmerge -d $prefix.rq.delta -q $qry -r $ref $options

