### Functional annotation of ORFs and genomes 

### prodigal v2.6.3

## ORFs prediction for 85 Contigs 

prodigal -p meta -q -m -i  03Assembly/contig/${sample}_contigs.fa   -a 04ORF/prodigal/${sample}_contigs_prodigal.faa -d 04ORF/prodigal/${sample}_contigs_prodigal.fna -o 04ORF/prodigal/${sample}_contigs_prodigal.gff -f gff  ;done 

seqkit seq -m 33  04ORF/prodigal/${sample}_contigs_prodigal.faa  >  04ORF/prodigal/${sample}_contigs_prodigal33.faa

### diamond v2.015

## annotate the nitrogen-cycling gene by diamond against the NCyc database

diamond blastp -k 1 -e 1e-5  -p 50 -d  NCyc/data/NCyc_100_2019Jul  -q 04ORF/prodigal/${sample}_contigs_prodigal33.faa  -o diamond/${sample}.tsv

### CDhit v4.8.1

## clutering for nonredundancy nitrogen-cycling genes

cd-hit -i All_nitrogen_gene.faa  -o CDhit/All_nitrogen_gene_centroids_1.faa -c 1

### dRep v3.4.0

## Raw 2,358 medium-high quality bins cluster into species level by dRep

time dRep dereplicate MAG_95 -pa 0.95 -cm larger -p 28 -sa 0.95 -comp 50 -con 10 -g 2358rawMAGs/*  &> drep_0.95.log&

### GTDB-tk (v2.1.1) GTDB database(r207)

## Taxonomic classficiton for 758 SGBs

gtdbtk classify_wf --genome_dir MAG_95/dereplicated_genomes  --out_dir classify_wf --extension fa  --cpus 20


### Prokka v1.14.6

## proteion predition for 758 SGBs 

prokka MAG_95/dereplicated_genomes/${SGBs_bac}.fa  --prefix ${SGBs_bac} --metagenome -cpus 30 --kingdom Bacteria --centre X --compliant

prokka MAG_95/dereplicated_genomes/${SGBs_arc}.fa  --prefix ${SGBs_arc} --metagenome -cpus 30 --kingdom Archaea --centre X --compliant


### diamond v2.015

## annotate the nitrogen-cycling gene by diamond against the NCyc database

diamond blastp -k 1 -e 1e-5  -p 50 -d  NCyc/data/NCyc_100_2019Jul  -q Prokka/${SGBs_bac}/${SGBs_bac}.faa  -o diamond/${n}.tsv
diamond blastp -k 1 -e 1e-5  -p 50 -d  NCyc/data/NCyc_100_2019Jul  -q Prokka/${SGBs_arc}/${SGBs_arc}.faa  -o diamond/${n}.tsv


### growthpred

### query cds sequences 

gffread  Prokka/${SGBs}/${SGBs}.gff -g MAG_95/dereplicated_genomes/${SGBs}.fa -x Data/${SGBs}.heg.fasta;done 

### prediction of OGT

growthpred-v1.08.py -d ./ -g Data/${SGBs}.heg.fasta -s -S -c 0 -o result/${SGBs}  -t -m -b ;done 

