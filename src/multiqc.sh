#! /bin/bash
#multiqc

data="/home/rstudio/disk/"
mkdir -p $data
cd $data
mkdir -p ConQual
mkdir -p ConQualSumm
#on cree le dossier si il n'existe pas
cd ConQual
# on va dans ConQual

#FASTQ=`ls $(pwd)`
#je definis la variable FASTQ et j'y inclue les fichiers de ConQual
#for file in $FASTQ
#do
#cp $file"_ConQual"/* $data
#fastqc $file -o $file"_ConQual"

#cd /home/disk/sra_data/
multiqc . -o /home/rstudio/disk/ConQualSumm
#dans concal je prends tous les fichiers et on met le output dans ConQualSumm
done