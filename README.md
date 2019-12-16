# NGS_Practicals_Medical
Bonjour A

#Petit jeu de données
Telechargement de toutes les données et changement des noms: j'ai lancé le script get_fastq_jeu.sh
Cela me créé un dichier sra_data_jeu dans disc 
Pour analyser la qualité des données je lance fastqc_jeu.sh et cela me regroupe les analyses dans le dossier ComQual_jeu
Pour synthetiser le control qualité de tous les échantillons, je lance multiqc_jeu.sh et cela me donne la synthese de l'analyse dans ConQualSumm_jeu
On creé le Fichier FastaAdaptateurs.fa dans disk contenant les séquences des adapattuers illumina et des poly T que l'on veut nettoyer des données. 
On lance trimmomatic_jeu.sh pour netoyer les données et les données nétoyées sont mises dans sra_data_jeu/trimmomatic_jeu/unpair ou pair 

#Grand jeu de données
Telechargement de toutes les données et changement des noms: j'ai lancé le script get_fastq.sh
Cela me créé un fichier sra_data dans disc 
Pour netoyer les données on utilise FastaAdaptateurs.fa et le script trimmomatic.sh et on dirige le output vers sra_data/trimmomatic/unpair ou sra_data/trimmomatic/pair
Pour voir la qualité du netoyage, on lance fastqc.sh avec l'Option 1 puis avec l'Option 2. 

On telecharge la banque d'ADNc à partir de https://www.ensembl.org/biomart/martview/91c89983d884d92c243fa6514b7ab239 grace au programme get_cDNA.sh 
On lance salmon.sh et on regarde le pourcetage de read alignés:

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
Pour cela on lance star.sh. 


