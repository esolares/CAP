#!/bin/bash

PREFIX="chardonnay"
PACBREADS="chardonnay.fastq"
canu -p ${PREFIX} -d ${PREFIX}-auto-sge genomeSize=600m -pacbio-raw ${PACBREADS} -s myspec.spec
