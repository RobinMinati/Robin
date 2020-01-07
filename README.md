# NGS_Practicals_Medical

###Petit jeu de données: On teste les programmes en ne télechangeant que les 100 000 premier reads de chanque échantillons. (Repondeur avant vs aprés traitement)
  
  @1. Telechargement de toutes les données et changement des noms.
J'ai lancé le script "get_fastq_jeu.sh"" et cela créé un fichier "sra_data_jeu" dans disk. 

  @2. Analyse qualité des données. 
Pour analyser la qualité des données, on lance "fastqc_jeu.sh" et cela regroupe les analyses dans le dossier "ComQual_jeu". Pour synthetiser le control qualité de tous les échantillons, on lance "multiqc_jeu.sh" et cela donne une synthese de l'analyse qualité dans "ConQualSumm_jeu". 

  @3. Nettoyage des données 
On creé le Fichier "FastaAdaptateurs.fa" dans disk contenant les séquences des adapattuers illumina et des poly T que l'on veut nettoyer. 
On lance "trimmomatic_jeu.sh" pour netoyer les données et les données nétoyées sont mises dans "sra_data_jeu/trimmomatic_jeu/unpair" ou ".../pair".  

Après cela, on commence à travailler avec notre "vrai"" jeu de donné (pas seulement les 100 000 premiers reads)


###Grand jeu de données

  @1. Telechargement de toutes les données et changement des noms.
On lance le script "get_fastq.sh". Cela me créé un fichier "sra_data" dans disk. 

 @2. Nettoyages des données et analyse de la qualité du nettoyage. 
Pour netoyer les données on utilise le "FastaAdaptateurs.fa" qui a été généré à partir du controle qualité du petit jeu de donnée et on lance le script "trimmomatic.sh" pour faire le nettoyage. On dirige le output vers un dossier "sra_data/trimmomatic/unpair" ou "sra_data/trimmomatic/pair". 
Pour controler la qualité du netoyage, on lance "fastqc.sh" avec l'Option 1 puis avec l'Option 2. 

  @3.Alignement sur le transcriptome humain avec SALMON
On telecharge la banque d'ADNc à partir de https://www.ensembl.org/biomart/martview/91c89983d884d92c243fa6514b7ab239 grace au programme "get_cDNA.sh". On lance "salmon.sh"" et on regarde le pourcetage de read alignés:
Afficher le pourcentage de read sur le genome de séquence "salmon |grep "Mapping rate""
salmon |grep "Mapping rate"
[2019-11-07 11:28:18.355] [jointLog] [info] Mapping rate = 16.5409%
[2019-11-07 11:41:52.876] [jointLog] [info] Mapping rate = 25.2388%
[2019-11-07 11:50:56.621] [jointLog] [info] Mapping rate = 24.0756%
[2019-11-07 11:59:41.399] [jointLog] [info] Mapping rate = 27.9652%
[2019-11-07 12:08:35.361] [jointLog] [info] Mapping rate = 29.2805%
[2019-11-07 12:16:47.517] [jointLog] [info] Mapping rate = 29.8859%
[2019-11-07 12:24:59.373] [jointLog] [info] Mapping rate = 22.2545%
[2019-11-07 12:33:11.632] [jointLog] [info] Mapping rate = 31.1653%
[2019-11-07 12:44:25.681] [jointLog] [info] Mapping rate = 30.7311%
[2019-11-07 12:58:22.595] [jointLog] [info] Mapping rate = 31.5226%
[2019-11-07 13:04:51.176] [jointLog] [info] Mapping rate = 27.9033%
[2019-11-07 13:22:34.039] [jointLog] [info] Mapping rate = 12.7717%
[2019-11-07 13:35:04.468] [jointLog] [info] Mapping rate = 18.8081%
On a très peu de read qui s'alignent sur les cDNAs. On va essayer de mapper cela sur le genome humain plutot que sur une banque d'ARNc. 

  @4. Alignement sur le genome humain avec STAR
Pour cela on lance le programme "star.sh.". Pour une question de taille de machine, nous n'avons pas pu générer l'index et nous avons utilisé l'index de Corentin (/home/rstudio/disk/Corentin/hg38_genome). On exporte le resultat en ficher bam (et non sam car cela accelere l'analyse après (/home/rstudio/disk//Star/$patient"_star".bam)

  @5. Vérification du mapping avec Qualimap
L'analyses du mapping sur le génome humain se fait en utilisant "qualimap.sh" cela nous donne des informations sur la qualité du mapping des reads sur le génome de référence qui a été généré par STAR. Due a des problemes de serveur nous n'avons pas pu lancer qualimap. 

  @6. Analyse statiqtique de la table de compte obtenu avec SALMON (en utilisant R) 
On analyse si les transcript sont differentiellement exprimés avant et apres traitement chez les responders. Pour cela nous avions commencé à rédiger un script (R script.R) mais due à un probleme technique nous nous n'avons pas pu le finir et nous avons fait une analyse à partir du script de Corentin (R script Bon.R).
En utilisant les metadonées des patients, on peut regarder si le sexe peut influencer la r&éponse au traitement. 




