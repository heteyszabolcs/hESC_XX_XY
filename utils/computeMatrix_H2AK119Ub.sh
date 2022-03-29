#!/bin/bash -l
#SBATCH -M snowy

module load bioinfo-tools
module load deepTools

# compute matrix over active genes
computeMatrix reference-point --referencePoint TSS \
	-S /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H2AK119Ub_401_pooled.hg38.scaled.bw \
	/proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H2AK119Ub_LT2e_pooled.hg38.scaled.bw \
	/proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H2AK119Ub_975_pooled.hg38.scaled.bw \
	/proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H2AK119Ub_980_pooled.hg38.scaled.bw \
	-R /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/hg38/ENCODE_hESC_active_genes.bed \
	--samplesLabel "H2AK119Ub - 401", "H2AK119Ub - LT2e", "H2AK119Ub - 975", "H2AK119Ub - 980" \
	-o /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/dt_matrix-encode_hesc_actgenes_H2AK119Ub_XX.gz	

computeMatrix reference-point --referencePoint TSS \
	-S /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H2AK119Ub_WA14_pooled.hg38.scaled.bw \
	/proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H2AK119Ub_KI001_pooled.hg38.scaled.bw \
	/proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H2AK119Ub_1001_pooled.hg38.scaled.bw \
	/proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H2AK119Ub_983a_pooled.hg38.scaled.bw \
	-R /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/hg38/ENCODE_hESC_active_genes.bed \
	--samplesLabel "H2AK119Ub - WA14", "H2AK119Ub - KI001", "H2AK119Ub - 1001", "H2AK119Ub - 983a" \
	-o /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/dt_matrix-encode_hesc_actgenes_H2AK119Ub_XY.gz