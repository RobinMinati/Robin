## DE analysis
library("tximport")
library("readr")
library(apeglm)
library("DESeq2",quietly = T)
library(ggplot2)

dir <- "/home/rstudio/disk" ### Ici mettre le dossier dans lequel vous travaillez => Ici on définit le chemin et on le met dans la variable dir. 

setwd("/home/rstudio/disk") 
#on se met dans Disk

# Location of the data:
condition <- read.table("condition.csv",header = T)
us=read.table("table_medical.csv")


# DE analysis : comparison 1 in the paper / with "our" data
dds <- DESeqDataSetFromMatrix(countData = round(us[,condition$type=="responding"],0),
                              colData = condition[condition$type=="responding",],
                              design = ~ patient + time)

#dds <- DESeq(dds)
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]
dds$time <- relevel(dds$time, ref = "before") # Ici ce à quoi on va se comparer.
dds <- DESeq(dds)
resultsNames(dds)
resLFC <- lfcShrink(dds, coef="time_after_vs_before", type="apeglm")
resLFC_resp <- resLFC

# 744 DE genes 5% FDR
plotMA(resLFC_resp,ylim=c(-4,4))
maplot <- ggplot(as.data.frame(resLFC_resp),aes(x=log10(baseMean),y=log2FoldChange,color=padj<0.05))+
  geom_point(mapping = aes(size=padj<0.05,alpha=padj<0.05,shape=padj<0.05,fill=padj<0.05))+theme_bw()+theme(legend.position = 'none')+
  scale_size_manual(values = c(0.1,1))+scale_alpha_manual(values = c(0.5,1))+
  scale_shape_manual(values=c(21,21))+scale_fill_manual(values = c("#999999","#05100e"))+
  scale_color_manual(values=c("#999999","#cc8167"))
maplot
resLFC_resp$padj[is.na(resLFC_resp$padj)] <- 1
resLFC_resp[resLFC_resp$padj<0.05 & abs(resLFC_resp$log2FoldChange)>3,] 
##on selectionne les genes qui sont singificativement different et qui sont au moins 8 fois plus/moins exprimés que dans l'autre condition.  


# DE analysis : comparison 2 in the paper / with "us" data
dds <- DESeqDataSetFromMatrix(countData = round(us[,condition$type=="non_responding"],0),
                              colData = condition[condition$type=="non_responding",],
                              design = ~ patient + time)

keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]
dds$time <- relevel(dds$time, ref = "before") # Ici ce à quoi on va se comparer.
dds <- DESeq(dds)
res <- results(dds)
resultsNames(dds)
resLFC <- lfcShrink(dds, coef="time_after_vs_before", type="apeglm")
resLFC_nonresp <- resLFC

# 33 DE genes 5% FDR
plotMA(resLFC_nonresp,ylim=c(-4,4))
maplot <- ggplot(as.data.frame(resLFC_nonresp),aes(x=log10(baseMean),y=log2FoldChange,color=padj<0.05))+
  geom_point(mapping = aes(size=padj<0.05,alpha=padj<0.05,shape=padj<0.05,fill=padj<0.05))+theme_bw()+theme(legend.position = 'none')+
  scale_size_manual(values = c(0.1,1))+scale_alpha_manual(values = c(0.5,1))+
  scale_shape_manual(values=c(21,21))+scale_fill_manual(values = c("#999999","#05100e"))+
  scale_color_manual(values=c("#999999","#cc8167"))
maplot
resLFC_nonresp$padj[is.na(resLFC_nonresp$padj)] <- 1
resLFC_nonresp[resLFC_nonresp$padj<0.05,]

# DE analysis : comparison 3 in the paper / with "us" data
dds <- DESeqDataSetFromMatrix(countData = round(us[,condition$time=="before"],0),
                              colData = condition[condition$time=="before",],
                              design = ~ type)
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]
dds$time <- relevel(dds$time, ref = "before") # Ici ce à quoi on va se comparer.
dds <- DESeq(dds)
res <- results(dds)
resultsNames(dds)
resLFC <- lfcShrink(dds, coef="type_responding_vs_non_responding", type="apeglm")
resLFC_bef <- resLFC

# 5 DE genes 5% FDR
plotMA(resLFC_bef,ylim=c(-4,4))
maplot <- ggplot(as.data.frame(resLFC_bef),aes(x=log10(baseMean),y=log2FoldChange,color=padj<0.05))+
  geom_point(mapping = aes(size=padj<0.05,alpha=padj<0.05,shape=padj<0.05,fill=padj<0.05))+theme_bw()+theme(legend.position = 'none')+
  scale_size_manual(values = c(0.1,1))+scale_alpha_manual(values = c(0.5,1))+
  scale_shape_manual(values=c(21,21))+scale_fill_manual(values = c("#999999","#05100e"))+
  scale_color_manual(values=c("#999999","#cc8167"))
maplot
resLFC_bef$padj[is.na(resLFC_bef$padj)] <- 1
resLFC_bef[resLFC_bef$padj<0.05,]

