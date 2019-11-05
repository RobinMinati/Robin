#! /bin/bash

# Hsapiens
data="/home/rstudio/disk/"
mkdir -p $data
cd $data
mkdir -p sra_data
cd sra_data
#On fait un fichier sra_data dans /home/rstudio/disk/

SRR="SRR3308956
SRR3308957
SRR3308963
SRR3308964
"
#On definit SRR comme variable et on y associe les numeros de sequences sur le NCBI

for srr in $SRR
do
# Produces one fastq file, single end data. 

fastq-dump $srr -O /home/rstudio/disk/sra_data -X 100000 
#pour chaque patient on telechanger les 100000 premieres reads et on les sauvegarde dans le dossier sra_data

#fastq-dump -h
#echo $srr
# rename sequence names
#awk  -F "\."  '{ if (NR%2 == 1 ) { $3= "" ; print $1 "_" $2 "/1"}  else  { print $0} }'
#...
done
