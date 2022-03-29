#!/bin/bash -l
#SBATCH -M snowy

module load bioinfo-tools
module load deepTools

# compute matrix over active genes
computeMatrix reference-point --referencePoint TSS \
	-S /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K27me3_401_pooled.hg38.scaled.bw \
	/proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K27me3_LT2e_pooled.hg38.scaled.bw \
	/proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K27me3_975_pooled.hg38.scaled.bw \
	/proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K27me3_980_pooled.hg38.scaled.bw \
	-R /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/hg38/ENCODE_hESC_active_genes.bed \
	--samplesLabel "H3K27me3 - 401", "H3K27me3 - LT2e", "H3K27me3 - 975", "H3K27me3 - 980" \
	-o /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/dt_matrix-encode_hesc_actgenes_H3K27me3_XX.gz

computeMatrix reference-point --referencePoint TSS \
	-S /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K27me3_WA14_pooled.hg38.scaled.bw \
	/proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K27me3_KI001_pooled.hg38.scaled.bw \
	/proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K27me3_1001_pooled.hg38.scaled.bw \
	/proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K27me3_983a_pooled.hg38.scaled.bw \
	-R /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/hg38/ENCODE_hESC_active_genes.bed \
	--samplesLabel "H3K27me3 - WA14", "H3K27me3 - KI001", "H3K27me3 - 1001", "H3K27me3 - 983a" \
	-o /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/dt_matrix-encode_hesc_actgenes_H3K27me3_XY.gz
	

