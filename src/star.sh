#! /bin/bash
#ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_32/gencode.v32.annotation.gtf.gz

data="/home/rstudio/disk"
mkdir -p $data
cd $data
mkdir -p Star
cd Star
mkdir -p index
cd index

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


#STAR --runThreadN 7 --runMode  genomeGenerate --genomeDir $data/Corentin/hg38_genome \
#--genomeFastaFiles $data/Hsap_genome.gtf \
#--sjdbGTFfile $data/Hsap_annotation.gtf --sjdbOverhang 100

##legend 
##--runThreadN NumberOfThreads
##--runMode genomeGenerate
##--genomeDir /path/to/genomeDir
##--genomeFastaFiles /path/to/genome/fasta1 /path/to/genome/fasta2 ... 
##--sjdbGTFfile /path/to/annotations.gtf
##--sjdbOverhang ReadLength-1

for patient in $SRR
do

STAR --runThreadN 7 --genomeDir $data/Corentin/hg38_genome \
--readFilesIn $Pair/$patient"_trimmed_paired_1.fastq" $Pair/$patient"_trimmed_paired_2.fastq" \
--outFileNamePrefix $data/Star/$patient"_star"

samtools view -bS $data/Star/$patient"_starAligned.out.sam" > $data/Star/$patient"_star".bam -h

rm $data/Star/$patient"_starAligned.out.sam"

#-h on garde l'entete 
#--outFileNamePrefix
#--runThreadN NumberOfThreads
#--genomeDir /path/to/genomeDir
#--readFilesIn /path/to/read1 [/path/to/read2]
#info STAR http://labshare.cshl.edu/shares/gingeraslab/www-data/dobin/STAR/STAR.posix/doc/STARmanual.pdf

#samtools out.sam > out.bam

done


