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

fastq-dump $srr -O /home/rstudio/disk/sra_data --split-files -I 

#pour chaque patient on telechanger les 100000 premieres reads et on les sauvegarde dans le dossier sra_data
#-X 100000 => telecharger les 100000 premieres sequences
#--split-files on sépare les sequences des deux extrémités du fragment -I (on garde le nom)
#fastq-dump -h (avoir de l'aide)
#echo $srr (afficher les srr)
# rename sequence names

awk  -F "\."  '{ if (NR%2 == 1 ) { $3= "" ; print $1 "_" $2 "/1"}  else  { print $0} }' $srr"_1.fastq" > temp1.fastq
awk  -F "\."  '{ if (NR%2 == 1 ) { $3= "" ; print $1 "_" $2 "/2"}  else  { print $0} }' $srr"_2.fastq" > temp2.fastq
mv temp1.fastq $srr'_1.fastq'
mv temp2.fastq $srr'_2.fastq'

#awk (modification ligne par ligne=> divise le ligne en morceaux) -F "\."(on coupe au viniveau d'un point caractere)  '{ if (NR%2 == 1 )si le numero de la signe est impair { $3= "" ; print $1 "_" $2 "/1"}  else  { print $0} }'
#...
done
