#! /bin/bash
#fastqc -h


# Hsapiens
data="/home/rstudio/disk/"
mkdir -p $data
cd $data
mkdir -p sra_data
cd sra_data
#on cree le dossier 
FASTQ=`ls $(pwd)`
#je definis la variable FASTQ et j'y inclue les fichiers de sra-data
cd ..
mkdir ConQual
cd sra_data
for file in $FASTQ
do
echo $file

fastqc $file -o /home/rstudio/disk/ConQual
# Produces one fastq file, single end data. 

#fastq-dump $srr -O /home/rstudio/disk/sra_data -X 100000 
#pour chaque patient on telechanger les 100000 premieres reads et on les sauvegarde dans le dossier sra_data

#fastq-dump 
#echo $srr
# rename sequence names
#awk  -F "\."  '{ if (NR%2 == 1 ) { $3= "" ; print $1 "_" $2 "/1"}  else  { print $0} }'
#...
done
