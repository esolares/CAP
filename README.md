# chardonnayassemblypipeline

The first stages consist of running the hybrid assembly approach and the self assembly approach independently. 

For the hybrid approach, Platanus is first run and contigs are generated. These contigs are then used in DBG2OLC along with 30x of the longest pacbio reads. This is done automatically in the script. The only thing DBG2OLC requires is the contigs file and the uncorrected fastq file of the pacbio reads.

After both assemblies are generated. Quickmerge is then run, which is denoted by the qm2x folder. This is done for two rounds.

Once this is done, the falcon assembly is then used, along with the resultant qm2x assembly. The falcon assembly is merged with the qm2x assembly twice, per chakraborty et al 2016 paper.  I will upload a graphic of this merging pipeline. This is done in the qm3x folder. Also note that polishing is also included in each folder, this is done to check the assembly contiguity and quality metrics at each step, but the polished assembly is not used for merging.

Once the falcon assembly and the qm2x assembly is merged, it is then polished, and undergoes the haplotig reduction step. This is done by using the qm3x vs qm3x blat alignment result, and filtering contigs that are encapsulated by other contigs. 

I used several calculations to choose the best reduced assembly by calculating queryalignmentlength/querylength and min(queryalignmentlength,referencealignmentlength)/max(queryalignmentlength,referencealignmentlength) and expected assembly size. Once serveral candidate reduced assemblies are generated, then the assembly with the best busco score is used. 
