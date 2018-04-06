#!/bin/bash
#$ -N platat
#$ -pe openmp 80
#$ -R Y
#$ -r yes
#$ -q bigmemory
### -l mem_size

#source binaries 
source ~/.mybashrc

#PATH=$PATH:/data/users/solarese/bin/platanus
OUTPUT="chardonnay_plat"

FQPREFIX1="L1"
FQPREFIX2="_R"
O1FQPREFIX=""
O2FQPREFIX=""
MPLIBLEN=""

#PE Trim
platanus_trim ${FQPREFIX1}6${FQPREFIX2}[12].fastq
platanus_trim ${FQPREFIX1}7${FQPREFIX2}[12].fastq
#platanus_internal_trim ${O1FQPREFIX}[12].fastq
#platanus_internal_trim ${O2FQPREFIX}[12].fastq
echo "end trim"

#contig assembly
platanus assemble -o ${OUTPUT} -f ${FQPREFIX1}[67]${FQPREFIX2}[12].fastq.trimmed -t 64 -m 460
echo "finished asm"

#scaffolding
#platanus scaffold -t 64 -o ${OUTPUT} -c ${OUTPUT}_contig.fa -b ${OUTPUT}_contigBubble.fa \
#   -IP1 ${FQPREFIX1}6${FQPREFIX2}[12].fastq.trimmed \
#   -IP2 ${FQPREFIX1}7${FQPREFIX2}[12].fastq.trimmed 
#   -OP2 ${O1FQPREFIX}[12].fastq.int_trimmed \
#   -OP3 ${O2FQPREFIX}[12].fastq.int_trimmed \
#   ${MPLIBLEN}

#echo "finished scaffolding"

#gap-closing
#platanus gap_close -o ${OUTPUT} -c ${OUTPUT}_scaffold.fa \
#   -IP1 ${FQPREFIX1}6${FQPREFIX2}[12].fastq.trimmed \
#   -IP2 ${FQPREFIX1}7${FQPREFIX2}[12].fastq.trimmed \
#   -OP2 ${O1FQPREFIX}[12].fastq.int_trimmed \
#   -OP3 ${O2FQPREFIX}[12].fastq.int_trimmed \
#   ${MPLIBLEN}

#echo "finished gap closing"
