# DESeq analysis Tp human
#DE Analysis:

# Libraries:
library(tximport)
library(readr)
library(apeglm)
library(DESeq2,quietly = T)

# Location of the data:
dir <- "/home/rstudio/disk" ### Ici mettre le dossier dans lequel vous travaillez => Ici on définit la direction. 

setwd("/home/rstudio/disk") 
#on se met dans Disk

# Import the data:
condition <- read.table("condition.csv",header = T) ### Donner la table des métadata => la premiere ligne ce sont des titres. 

files <- file.path(dir,"salmon", paste0(condition$sample,"_salmon_quant"), "quant.sf")
names(files) <- condition$sample

patient <- c("SRR3308956",
             "SRR3308957",
             "SRR3308963",
             "SRR3308964",
             "SRR3308972",
             "SRR3308973",
             "SRR3308974",
             "SRR3308975",
             "SRR3308976",
             "SRR3308978",
             "SRR3308979",
             "SRR3308982",
             "SRR3308983")
files <- files[patient]

# Data frame to known association gene transcript:
tx2gene <- as.character(read.table(files[1],header = T,sep = "\t")$Name)
trinity.genes <- unlist(lapply(lapply(strsplit(x = tx2gene,split = "|",fixed=T),FUN = `[`,1),paste,collapse="_"))
trinity.trans <- unlist(lapply(lapply(strsplit(x = tx2gene,split = "|",fixed=T),FUN = `[`,1:3),paste,collapse="|"))
tx2gene <- data.frame(txname=trinity.trans,geneid=trinity.genes)

txi <- tximport(files,type="salmon",tx2gene=tx2gene)

## On peut afficher la table de compte avec :
head(txi$counts)


ddsTxi <- DESeqDataSetFromTximport(txi,
                                   colData = ... ,
                                   design = ... )