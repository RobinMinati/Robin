#! /bin/bash
## Run trimmomatic

Pair=/home/rstudio/disk/sra_data/trimmomatic/pair
UnPair=/home/rstudio/disk/sra_data/trimmomatic/unpair
#Je définis deux variables correspondants aux chemin des dossiers pair et unpair

data="/home/rstudio/disk/"
mkdir -p $data
cd $data
cd sra_data
mkdir -p trimmomatic
cd trimmomatic
mkdir -p pair
mkdir -p unpair
# si il n'existe pas, dans le dossier sra_data, je créé un nouveau dossier nommé trimmomatic que je divise en dossier pair et unpair

cd /home/rstudio/disk/sra_data
#je me place dans le dossier sra_data

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
#je pose la variable SRR qui continet les differents SRR

for patient in $SRR;
do
	java -jar /softwares/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
	$patient"_1.fastq" $patient"_2.fastq" \
	$Pair/$patient"_trimmed_paired_1.fastq" $UnPair/$patient"_trimmed_unpaired_1.fastq" \
	$Pair/$patient"_trimmed_paired_2.fastq" $UnPair/$patient"_trimmed_unpaired_2.fastq" -threads 7 \
	ILLUMINACLIP:/home/rstudio/disk/FastaAdapteurs.fa:2:30:10 LEADING:22 SLIDINGWINDOW:4:22 MINLEN:25
	
#Pour chaque patient que contient SRR, on run Trimmomatic avec la fonction PE (pair ends). 
#La ligne 41 sont les données prisent par le programme 
#les lignes 42 et 43 sont les outputs et la nommenclarure 
#on fait un illuminaclip pour enlever les adapeturs illumina et les séquences poly T (qu'on a resneignées dans le fichier FastaAdapteurs.fa)
#on fait fait un leading pour enlever les premieres bases du read si elles sont en desous du treshold de qualité (22)
#on fait in slidingdown pour couper la séquence quand la qualité moyenne dans la fenetre (4)tombe en dessous du seuil (22)
#on fait un minlen pour retirer les reads qui font moins de 25 paires de bases 


#ILLUMINACLIP:<fastaWithAdaptersEtc>:<seed mismatches>:<palindrome clip threshold>:<simple clip threshold>
#SLIDINGWINDOW:<windowSize>:<requiredQuality>
#java -jar <path to trimmomatic.jar> PE [-threads <threads] [-phred33 | -phred64] [-trimlog <logFile>] <input 1> <input 2> <paired output 1> <unpaired output 1> <paired output 2> <unpaired output 2> <step 1> ...
#	java -jar /softwares/Trimmomatic-0.39/trimmomatic-0.39.jar -h
#PE= pair ends
# \=retour a la ligne mais meme commande 
# sur Mac MAJ+ALT+/ = \
#-threads = nombre de coeurs consacrés à l'analyse 
done

