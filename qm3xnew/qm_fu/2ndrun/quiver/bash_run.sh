#!/bin/bash
##only for order purposes:

bash bash_prep_pbalign.sh
bash qsub_pbalign.sh
bash qsub_cmph_merge.sh
bash qsub_quiver.sh
