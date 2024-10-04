### Estimated metagenomic abundance and transcriptional activity for nonredundancy NCGs and SGBs

### abundance calculation for SGBs
### CoverM v0.6.1

coverm genome --coupled 02Cleandata/Trimgalore_out/${sample}_1.fq.gz  02Cleandata/Trimgalore_out/${sample}_2.fq.gz -t ${thread} --methods tpm --genome-fasta-files MAG_95/dereplicated_genomes/* -x fa -o Raw_result/${sample}_coverm.tsv


### abundance calculation for NCGs
### salmon v0.13.1

## salmon index
time salmon index -p 2 -t All_nitrogen_gene_centroids_1.faa  -i salmon_index  >index.log &

salmon quant -i   salmon_index -l A  -1 02Cleandata/Trimgalore_out/${sample}_1.fq.gz   -2  02Cleandata/Trimgalore_out/${sample}_2.fq.gz    -p 20  --validateMappings -o salmon_result/${i##*/}_quant  >salmon_result/${sample}.log


### activity calculation for SGBs
## Bowtie2 v2.2.5 and Samtools v1.15.1

cat MAG_95/dereplicated_genomes/* >758SGB.fasta

bowtie2-build 758SGB.fasta  bt2/758SGB
bowtie2 -p 6  -x bt2/758SGB -1 02Cleandata/${sample}unalign_fwd.fq.gz  -2 02Cleandata/${sample}unalign_rev.fq.gz  | samtools view -bS -@ 20 -q 30 | samtools sort -@ 20 >bt2bam/${sample}.sorted.bam 

### CoverM v0.6.1

coverm genome --bam-files ${sample}.sorted.bam   -t 5  --genome-fasta-directory  MAG_95/dereplicated_genomes   --methods covered_fraction -x fa  --min-read-percent-identity 95 --min-read-aligned-percent 75  -o process/${sample}_coverage_id90cov75.tsv  

### activity calculation for NCGs
## Bowtie2 v2.2.5 and Samtools v1.15.1


bowtie2-build All_nitrogen_gene_centroids_1.fna bt2/All_nitrogen_gene_centroids_1

bowtie2 -p 6  -x bt2/All_nitrogen_gene_centroids_1 -1 02Cleandata/${sample}unalign_fwd.fq.gz  -2 02Cleandata/${sample}unalign_rev.fq.gz  | samtools view -bS -@ 20 -q 30 | samtools sort -@ 20 >bt2bam/${sample}.sorted.bam 

### CoverM v0.6.1

coverm contig  --bam-files bt2bam/${sample}.sorted.bam   -t 10  --methods covered_fraction  --min-read-percent-identity 95 --min-read-aligned-percent 75  -o process/${sample}_coverage_id90cov75.tsv  
