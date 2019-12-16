#! /bin/bash

data="/home/rstudio/disk/"
mkdir -p $data
cd $data
mkdir -p salmon
cd salmon

SRR="SRR3308956
SRR3308957
SRR3308963
SRR3308964
SRR3308972
SRR3308973
SRR3308974
SRR3308975
SRR3308976
SRR3308978
SRR3308979
SRR3308982
SRR3308983
"
#On definit SRR comme une variable qui peut prendre la valeur des differents SRR

Pair=/home/rstudio/disk/sra_data/trimmomatic/pair

## Run salmon

salmon index -t /home/rstudio/disk/Hsap_cDNA.fa -i transcripts_index -k 23
# on met k=23 car des sequneces du genome sont plus petites que le defaut de 31 nucleotides

for patient in $SRR
do
salmon quant -i transcripts_index -l A -1 $Pair/$patient"_trimmed_paired_1.fastq" -2 $Pair/$patient"_trimmed_paired_2.fastq" \
--validateMappings \
-o $data/salmon/$patient"_salmon_quant" -p 7 --gcBias
# -p => on donne le nombre de coeurs qu'on met pour faire l'analyse
# --gcBias = corrige le biais d'observation des reads par rapport aux GC
#A salmon detecte tout seul la librairie
#https://salmon.readthedocs.io/en/latest/salmon.html#p-threads

done


