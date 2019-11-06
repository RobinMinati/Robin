# NGS_Practicals_Medical
Bonjour A

Grand jeu de données
Telechargement de toutes les données et changement des noms: j'ai lancé le script get_fastq.sh
Cela me créé un dichier sra_data dans disc 




Petit jeu de données
Telechargement de toutes les données et changement des noms: j'ai lancé le script get_fastq_jeu.sh
Cela me créé un dichier sra_data_jeu dans disc 
Pour analyser la qualité des données je lance fastqc_jeu.sh et cela me regroupe les analyses dans le dossier ComQual_jeu
Pour synthetiser le control qualité de tous les échantillons, je lance multiqc_jeu.sh et cela me donne la synthese de l'analyse dans ConQualSumm_jeu
On creé le Fichier FastaAdaptateurs.fa dans disk contenant les séquences des adapattuers illumina et des poly T que l'on veut nettoyer des données. 
On lance trimmomatic_jeu.sh pour netoyer les données et les données nétoyées sont mises dans sra_data_jeu/trimmomatic_jeu/unpair ou pair 
