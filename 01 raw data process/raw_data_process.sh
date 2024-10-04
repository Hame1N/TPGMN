### metatgenomic  rawdata link  https://www.biosino.org/node/analysis/detail/OEZ008893

### Trimglare v0.39

## quality control of raw reads by Trimglare

time trim_galore --paired  -j 8 --fastqc  -o 02Cleandata/Trimgalore_out 01Rawdata/${sample}.R1.fq.gz 01Rawdata/${sample}.R2.fq.gz &> 02Cleandata/Trimgalore_out/${sample}.log


### metatranscriptomic  rawdata link  PRJNA1105542 in SRA database

### Trimglare v0.39

## quality control of raw reads by Trimglare

time trim_galore --paired  -j 8 --fastqc  -o 02Cleandata/Trimgalore_out 01Rawdata/${sample}.R1.fq.gz 01Rawdata/${sample}.R2.fq.gz &> 02Cleandata/Trimgalore_out/${sample}.log


### sortmeRNA v4.3.6

## removal of rRNA reads by sortmeRNA

sortmerna --ref /data01nfs/user/liupf/software_lpf/sortmeRNA_db/rfam-5.8s-database-id98.fasta --ref /data01nfs/user/liupf/software_lpf/sortmeRNA_db/rfam-5s-database-id98.fasta --ref /data01nfs/user/liupf/software_lpf/sortmeRNA_db/silva-arc-16s-id95.fasta --ref /data01nfs/user/liupf/software_lpf/sortmeRNA_db/silva-arc-23s-id98.fasta --ref /data01nfs/user/liupf/software_lpf/sortmeRNA_db/silva-bac-16s-id90.fasta --ref /data01nfs/user/liupf/software_lpf/sortmeRNA_db/silva-bac-23s-id98.fasta --ref /data01nfs/user/liupf/software_lpf/sortmeRNA_db/silva-euk-18s-id95.fasta --ref /data01nfs/user/liupf/software_lpf/sortmeRNA_db/silva-euk-28s-id98.fasta --fastx -a 20 -v --log --reads /datanode02/zhangzh/MetaT/02Cleandata/Trimgalore_out/${sample}_clean_R1.fq.gz  --reads /datanode02/zhangzh/MetaT/02Cleandata/Trimgalore_out/${sample}_clean_R2.fq.gz --aligned ${sample}.align --other ${sample}.unalign --paired_in --out2 --workdir /datanode02/zhangzh/MetaT/02Cleandata/sortmeRNA/${sample}  

