# DESeq analysis Tp human
#DE Analysis:

# Libraries:
library(tximport)
library(readr)
library(apeglm)
library(DESeq2,quietly = T)
#on télécharge les librairies/programmes dont on a besoin 

# Location of the data:
dir <- "/home/rstudio/disk" ### Ici mettre le dossier dans lequel vous travaillez => Ici on définit le chemin et on le met dans la variable dir. 

setwd("/home/rstudio/disk") 
#on se met dans Disk

# Import the data:
condition <- read.table("condition.csv",header = T) ### Donner la table des métadata => la premiere ligne ce sont des titres. 
#dans la variable condition, on met le tableau avec les métabonnées (échantillon, sexe, type et patient) et on lui dit que la premiere ligne ce sont des titres

files <- file.path(dir,"salmon", paste0(condition$sample,"_salmon_quant"), "quant.sf")
#dans la variable file, on met le chemin vers des fichier quant.sf générés par salmon. 
names(files) <- condition$sample
#on nomme le chemin file par le nom de l'échnatillon qu'on récupére dans la colone sample du tableau condition

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

#on définit "patient" comme l'ensemble des patients cités. 

files <- files[patient]
# on modifit files pour qu'il ne garde que le subset patient => on ne veut que les chemins des patients. les autres n'existent pas. 

# Data frame to known association gene transcript:
tx2 <- as.character(read.table(files[1],header = T,sep = "\t")$Name)
Perou.genes <- unlist(lapply(lapply(strsplit(x = tx2,split = "|",fixed=T),FUN = `[`,1),paste,collapse="_"))
Perou.trans <- unlist(lapply(lapply(strsplit(x = tx2,split = "|",fixed=T),FUN = `[`,1:3),paste,collapse="|"))
tx2 <- data.frame(txname=Perou.trans,geneid=Perou.genes)

txi <- tximport(files,type="salmon",tx2gene=tx2)

## On peut afficher la table de compte avec :
head(txi$counts)


ddsTxi <- DESeqDataSetFromTximport(txi, 
                                  colData = condition ,
                                   design = ~time)
##On compare en fonction du temps => avant et apres traitement. 
dds <- DESeq(ddsTxi)
res <- results(dds, name="before_vs_after")
res

resLFC <- lfcShrink(dds, coef="before_vs_after", type="apeglm")
resLFC

plotMA(res, ylim=c(-8,8))
#on affiche le MA plot avec le Log fold change shrinkage for visualization and ranking

vsd <- vst(dds, blind=FALSE)
rld <- rlog(dds, blind=FALSE)
head(assay(vsd), 3)

##Function de plotPCA

plotPCA = function(object, intgroup="condition", ntop=500, returnData=FALSE)
{
  # calculate the variance for each gene
  rv <- rowVars(assay(object))
  
  # select the ntop genes by variance
  select <- order(rv, decreasing=TRUE)[seq_len(min(ntop, length(rv)))]
  
  # perform a PCA on the data in assay(x) for the selected genes
  pca <- prcomp(t(assay(object)[select,]))
  
  # the contribution to the total variance for each component
  percentVar <- pca$sdev^2 / sum( pca$sdev^2 )
  
  if (!all(intgroup %in% names(colData(object)))) {
    stop("the argument 'intgroup' should specify columns of colData(dds)")
  }
  
  intgroup.df <- as.data.frame(colData(object)[, intgroup, drop=FALSE])
  
  # add the intgroup factors together to create a new grouping factor
  group <- if (length(intgroup) > 1) {
    factor(apply( intgroup.df, 1, paste, collapse=":"))
  } else {
    colData(object)[[intgroup]]
  }
  
  # assembly the data for the plot
  d <- data.frame(PC1=pca$x[,1], PC2=pca$x[,2], group=group, intgroup.df, name=colnames(object))
  
  if (returnData) {
    attr(d, "percentVar") <- percentVar[1:2]
    return(d)
  }
  
  ggplot(data=d, aes_string(x="PC1", y="PC2",color=intgroup[2],shape=intgroup[1])) + geom_point(size=3) + 
    xlab(paste0("PC1: ",round(percentVar[1] * 100),"% variance")) +
    ylab(paste0("PC2: ",round(percentVar[2] * 100),"% variance")) +
    coord_fixed()
}

#plotPCA(vsd, intgroup=c("sex", "time"))
plotPCA(vsd, intgroup=c("patient", "sex"))
