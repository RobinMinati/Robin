#! /bin/bash

# Hsapiens
data="/home/rstudio/disk/"
mkdir -p $data
cd $data
mkdir -p sra_data
cd sra_data
#On fait un fichier sra_data dans /home/rstudio/disk/ si il n'existe pas

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

for srr in $SRR
do
fastq-dump $srr -O /home/rstudio/disk/sra_data --split-files -I 

#pour chaque patient on telechanger tous les reads et on les sauvegarde dans le dossier sra_data en gardant les informations (-I)

#-X 100000 => telecharger les 100000 premieres sequences
#--split-files on sépare les sequences des deux extrémités du fragment -I (on garde le nom)
#fastq-dump -h (avoir de l'aide)
#echo $srr (afficher les srr)
# rename sequence names

awk  -F "\."  '{ if (NR%2 == 1 ) { $3= "" ; print $1 "_" $2 "/1"}  else  { print $0} }' $srr"_1.fastq" > temp1.fastq
awk  -F "\."  '{ if (NR%2 == 1 ) { $3= "" ; print $1 "_" $2 "/2"}  else  { print $0} }' $srr"_2.fastq" > temp2.fastq
mv temp1.fastq $srr'_1.fastq'
mv temp2.fastq $srr'_2.fastq'
#on divise ligne par ligne et on coupe les mots aprés les points. 
#Si la ligne est impair on remplace supprime le block 3 ($3) puis on affiche le block 1 puis _ puis le $2 puis /1 ou /2.
#On nomme le fichier temp1.fastq ou temp1.fastq et on les renomme par le SRR+extension _1.fastq ou _2.fastq
#awk (modification ligne par ligne=> divise le ligne en morceaux) -F "\."(on coupe au viniveau d'un point caractere)  '{ if (NR%2 == 1 )si le numero de la signe est impair { $3= "" ; print $1 "_" $2 "/1"}  else  { print $0} }'
#...
done
