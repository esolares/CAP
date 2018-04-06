#!/bin/bash
#tar xzvf *-extra.tar.gz
ln -s /bio/solarese/grape/rsii/extra
ls extra/*.bax.h5 > input_master.fofn
NUMFILES=$(( $(wc -l input_master.fofn | cut -d ' ' -f1)/3))
rm myjoblist.txt
for i in $(seq 1 $NUMFILES)
   do head -n $((${i}*3)) input_master.fofn | tail -n 3 > input_${i}.fofn
   echo $i >> myjoblist.txt
done

