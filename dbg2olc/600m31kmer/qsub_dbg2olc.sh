#!/bin/bash
#$ -N dbg10a
#$ -pe openmp 2
#$ -R Y
#$ -q bigmemory,bio

#module load blasr/20140724
module load mchakrab/dbg2olc
module load smrtanalysis canu/2016-01-13

CONTIGFILE="chardonnay_plat_contig.fa"
FULLPBREADS="chardonnay.fastq"
BACKBONERAWFA="backbone_raw.fasta"
DBG2OLCCONS="DBG2OLC_Consensus_info.txt"
COVERAGE=30
GENOMESIZE=600000000
#GENOMESIZE=550000000
#GENOMESIZE=12000000
#GENOMESIZE=14000000
#GENOMESIZE=15000000
PREFIX=$(basename ${FULLPBREADS} .fastq)
PACBIOREADS="${PREFIX}_${COVERAGE}x.u.fastq"

if [ $(echo ${FULLPBREADS} | awk -F . '{print $NF}') = "fastq" ] || [ $(echo ${FULLPBREADS} | awk -F . '{print $NF}') = "fq" ]; then
   echo "calculate top ${COVERAGE}x for genomesize: ${GENOMESIZE} for ${PREFIX}"
   ln -s ${FULLPBREADS} $(basename ${FULLPBREADS} .fastq).u.fastq
   fastqSample -I ${PREFIX} -U -O ${PREFIX}_${COVERAGE}x -max -g ${GENOMESIZE} -c ${COVERAGE}
   echo "end calculate"
   sed '/^@/!d;s//>/;N' ${PACBIOREADS} > $(basename ${PACBIOREADS} .fastq).fasta
   PACBIOREADS="${PREFIX}_${COVERAGE}x.u.fasta"
else
   echo "please give a fastq input file"
   exit 1
fi

###overlap
###using contig file as input example
#DBG2OLC k KmerSize AdaptiveTh THRESH_VALUE1 KmerCovTh THRESH_VALUE2 MinOverlap THRESH_VALUE3 \
#   Contigs NGS_CONTIG_FILE \
#   f LONG_READS.FASTA RemoveChimera 1

###parameter tuning
##For 10x/20x PacBio data:
#KmerCovTh 2-5, MinOverlap 10-30, AdaptiveTh 0.001~0.01
##For 50x-100x PacBio data:
#KmerCovTh 2-10, MinOverlap 50-150, AdaptiveTh 0.01-0.02

MYLD=0
MYKVAL=31
MYKMERCOV=2
MYADAPT=0.01
MYMINOVL=30
MYRMCH=1

echo "begin dbg2olc step 1 overlap"
#DBG2OLC_Linux k 17 AdaptiveTh 0.001 KmerCovTh 2 MinOverlap 10 RemoveChimera 1 \
#   Contigs ${CONTIGFILE} \
#   f ${PACBIOREADS}
#
DBG2OLC_Linux LD ${MYLD} k ${MYKVAL} AdaptiveTh ${MYADAPT} KmerCovTh ${MYKMERCOV} \
   MinOverlap ${MYMINOVL} RemoveChimera ${MYRMCH} \
   Contigs ${CONTIGFILE} \
   f ${PACBIOREADS}
echo "end dbg2olc step 1 overlap"

###consensus
#check n50 of backbone file first; proceed if ok
#concat pbreads and contigs

cat ${CONTIGFILE} ${PACBIOREADS} > ctg_pb.fasta

#ulimit -n unlimited

#consensus script SPARC
#split_and_run_sparc.sh backbone_raw.fasta DBG2OLC_Consensus_info.txt \
#   ctg_pb.fasta \
#   ./consensus_dir 2 > cns_log.txt

#consensus script PBDAGCON
echo "begin dbg2olc step 2 consensus"
split_and_run_pbdagcon.sh backbone_raw.fasta DBG2OLC_Consensus_info.txt \
    ctg_pb.fasta \
    ./consensus_dir 2>cns_log.err 1>cns_log.out
echo "end dbg2olc step 2 consensus"

cp consensus_dir/final_assembly.fasta ./${PREFIX}_${COVERAGE}x_LD${MYLD}_K${MYKVAL}_KCOV${MYKCOV}_ADAPT${MYADAPT}_MINOVL${MYMINOVL}_RMCHIM${MYRMCH}_asm.fasta
rm -rf consensus_dir

