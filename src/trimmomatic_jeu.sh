#! /bin/bash
## Run trimmomatic

Pair=/home/rstudio/disk/sra_data_jeu/trimmomatic_jeu/pair
UnPair=/home/rstudio/disk/sra_data_jeu/trimmomatic_jeu/unpair

data="/home/rstudio/disk/"
mkdir -p $data
cd $data
cd sra_data_jeu
mkdir -p trimmomatic_jeu
cd trimmomatic_jeu
mkdir -p pair
mkdir -p unpair
cd /home/rstudio/disk/sra_data_jeu
#On fait un dossier trimmomatic 

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
#On definit SRR comme variable et on y associe les numeros de sequences sur le NCBI

for patient in $SRR;
do
	java -jar /softwares/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
	$patient"_1.fastq" $patient"_2.fastq" \
	$Pair/$patient"_trimmed_paired_1.fastq" $UnPair/$patient"_trimmed_unpaired_1.fastq" \
	$Pair/$patient"_trimmed_paired_2.fastq" $UnPair/$patient"_trimmed_unpaired_2.fastq" -threads 7 \
	ILLUMINACLIP:/home/rstudio/disk/FastaAdapteurs.fa:2:30:10 LEADING:22 SLIDINGWINDOW:4:22 MINLEN:25
	
#ILLUMINACLIP:<fastaWithAdaptersEtc>:<seed mismatches>:<palindrome clip threshold>:<simple clip threshold>
#SLIDINGWINDOW:<windowSize>:<requiredQuality>
#java -jar <path to trimmomatic.jar> PE [-threads <threads] [-phred33 | -phred64] [-trimlog <logFile>] <input 1> <input 2> <paired output 1> <unpaired output 1> <paired output 2> <unpaired output 2> <step 1> ...
#	java -jar /softwares/Trimmomatic-0.39/trimmomatic-0.39.jar -h
#PE= pair ends
# \=retour a la ligne mais meme commande 
# sur Mac MAJ+ALT+/ = \
#-threads = nombre de coeurs consacrés à l'analyse 
done

