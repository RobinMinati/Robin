#! /bin/bash
#echo "Need to add a dependency : "
#sudo apt-get install libxtst6 -y

data="/home/rstudio/disk"
mkdir -p $data
cd $data
mkdir -p Star

star=/home/rstudio/disk/Star

cd $star
mkdir -p qualimap
cd $star/qualimap

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

for patient in $SRR
do

#OPTION 1 => trier les données 

#cd $star/qualimap
#mkdir -p $patient"_qualimap" 
##on fait un dossier par patient

#cd $star
## sort the bam using samtools

#samtools sort -o $star/qualimap/$patient"_qualimap"/$patient".bam" -O bam -n -@ 7 $star/$patient"_star.bam"

##-o => output
##-O => faire un fichier bam
##-n => on trie par nom et pas par rappport à la position dans chromosomique
##-@ => nombre de coeurs plus donner l'input

#OPTION 2 => Faire le qualimap 

cd $star/qualimap
mkdir -p DATA 
cd DATA
qualimap rnaseq -bam $star/qualimap/$patient"_qualimap"/$patient".bam" \
-gtf $data/Hsap_annotation.gtf \
-outfile $star/qualimap/DATA/$patient_qualimap.html \
-pe -s

#qualimap <tool_name>  => on utilise le tool rnaseq

done 

#qualimap rnaseq 

