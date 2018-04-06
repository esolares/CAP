#!/bin/bash
JOBFILE="myjoblist.txt"

#tar xzvf *-extra.tar.gz
ls extra/*.bax.h5 > input_master.fofn
[ -e ${JOBFILE} ] && rm -f ${JOBFILE}
NUMFILES=$(( $(wc -l input_master.fofn | cut -d ' ' -f1)/3))
for i in $(seq 1 $NUMFILES)
   do head -n $((${i}*3)) input_master.fofn | tail -n 3 > input_${i}.fofn
      echo ${i} >> ${JOBFILE}
done
