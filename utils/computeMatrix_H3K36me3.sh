#!/bin/bash -l
#SBATCH -M snowy

module load bioinfo-tools
module load deepTools

# reference point
# computeMatrix reference-point --referencePoint TSS \
	# -S /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K36me3_WA14_pooled.hg38.scaled.bw \
	# /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K36me3_KI001_pooled.hg38.scaled.bw \
	# /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K36me3_1001_pooled.hg38.scaled.bw \
	# /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K36me3_983a_pooled.hg38.scaled.bw \
	# -R /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/hg38/ENCODE_hESC_active_genes.bed \
	# --samplesLabel "H3K36me3 - WA14", "H3K36me3 - KI001", "H3K36me3 - 1001", "H3K36me3 - 983a" \
	# -o /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/dt_matrix-encode_hesc_actgenes_H3K36me3_XY.gz

# computeMatrix reference-point --referencePoint TSS \
	# -S /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K36me3_401_pooled.hg38.scaled.bw \
	# /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K36me3_LT2e_pooled.hg38.scaled.bw \
	# /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K36me3_975_pooled.hg38.scaled.bw \
	# /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K36me3_980_pooled.hg38.scaled.bw \
	# -R /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/hg38/ENCODE_hESC_active_genes.bed \
	# --samplesLabel "H3K36me3 - 401", "H3K36me3 - LT2e", "H3K36me3 - 975", "H3K36me3 - 980" \
	# -o /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/dt_matrix-encode_hesc_actgenes_H3K36me3_XX.gz

# scale region
computeMatrix scale-regions -S /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K36me3_WA14_pooled.hg38.scaled.bw \
	/proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K36me3_KI001_pooled.hg38.scaled.bw \
	/proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K36me3_1001_pooled.hg38.scaled.bw \
	/proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K36me3_983a_pooled.hg38.scaled.bw \
	-R /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/hg38/ENCODE_hESC_active_genes.bed \
	--samplesLabel "H3K36me3 - WA14", "H3K36me3 - KI001", "H3K36me3 - 1001", "H3K36me3 - 983a" \
	-o /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/dt_matrix-sr_encode_hesc_actgenes_H3K36me3_XY.gz

computeMatrix scale-regions -S /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K36me3_401_pooled.hg38.scaled.bw \
	/proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K36me3_LT2e_pooled.hg38.scaled.bw \
	/proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K36me3_975_pooled.hg38.scaled.bw \
	/proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/bigwig/H3K36me3_980_pooled.hg38.scaled.bw \
	-R /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/data/hg38/ENCODE_hESC_active_genes.bed \
	--samplesLabel "H3K36me3 - 401", "H3K36me3 - LT2e", "H3K36me3 - 975", "H3K36me3 - 980" \
	-o /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/dt_matrix-sr_encode_hesc_actgenes_H3K36me3_XX.gz
