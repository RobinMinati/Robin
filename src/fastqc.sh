#! /bin/bash
#fastqc -h


# Hsapiens
data="/home/rstudio/disk/"
mkdir -p $data
cd $data
mkdir -p sra_data
cd sra_data
#on cree le dossier sra_data si il n'existe pas

FASTQ=`ls $(pwd)`
#on pose la variable FASTQ comme étant la liste des fichiers de sra-data
cd ..
mkdir ConQual
#je sors de sra_data et je crée un dossier ConQal

cd sra_data

for file in $FASTQ
do
echo $file

fastqc $file -o /home/rstudio/disk/ConQual
#pour tous les fichiers de la variable, je run fastqc et je dirige l'output vers ConQual

# Produces one fastq file, single end data. 
#fastq-dump $srr -O /home/rstudio/disk/sra_data -X 100000 
#pour chaque patient on telechanger les 100000 premieres reads et on les sauvegarde dans le dossier sra_data
#fastq-dump 
#echo $srr
# rename sequence names
#awk  -F "\."  '{ if (NR%2 == 1 ) { $3= "" ; print $1 "_" $2 "/1"}  else  { print $0} }'
#...
done
