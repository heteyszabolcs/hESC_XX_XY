#!/bin/bash -l
#SBATCH -M snowy

module load bioinfo-tools
module load deepTools

# plot over active genes
# plotHeatmap -m /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/dt_matrix-encode_hesc_actgenes_H3K27me3_XX.gz \
		# --yMin 0 \
		# --yMax 10 \
		# -out /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/actgenes_H3K27me3_XX.png
# plotHeatmap -m /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/dt_matrix-encode_hesc_actgenes_H3K27me3_XY.gz \
		# --yMin 0 \
		# --yMax 10 \
		# -out /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/actgenes_H3K27me3_XY.png	  
# plotHeatmap -m /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/dt_matrix-encode_hesc_actgenes_H3K4me3_XX.gz \
		# --yMin 0 \
		# --yMax 10 \
		# -out /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/actgenes_H3K4me3_XX.png
# plotHeatmap -m /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/dt_matrix-encode_hesc_actgenes_H3K4me3_XY.gz \
		# --yMin 0 \
		# --yMax 10 \
		# -out /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/actgenes_H3K4me3_XY.png
# plotHeatmap -m /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/dt_matrix-encode_hesc_actgenes_H3K27Ac_XX.gz \
		# --yMin 0 \
		# --yMax 10 \
		# -out /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/actgenes_H3K27Ac_XX.png
# plotHeatmap -m /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/dt_matrix-encode_hesc_actgenes_H3K27Ac_XY.gz \
		# --yMin 0 \
		# --yMax 10 \
		# -out /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/actgenes_H3K27Ac_XY.png
plotHeatmap -m /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/dt_matrix-encode_hesc_actgenes_H3K36me3_XX.gz \
		--yMin 0 \
		--yMax 10 \
		-out /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/actgenes_H3K36me3_XX.png
plotHeatmap -m /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/dt_matrix-encode_hesc_actgenes_H3K36me3_XY.gz \
		--yMin 0 \
		--yMax 10 \
		-out /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/actgenes_H3K36me3_XY.png
plotHeatmap -m /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/dt_matrix-sr_encode_hesc_actgenes_H3K36me3_XX.gz \
		--yMin 0 \
		--yMax 10 \
		-out /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/actgenes_sr_H3K36me3_XX.png
plotHeatmap -m /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/dt_matrix-sr_encode_hesc_actgenes_H3K36me3_XY.gz \
		--yMin 0 \
		--yMax 10 \
		-out /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/actgenes_sr_H3K36me3_XY.png
plotHeatmap -m /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/dt_matrix-encode_hesc_actgenes_H2AK119Ub_XX.gz \
		--yMin 0 \
		--yMax 10 \
		-out /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/actgenes_H2AK119Ub_XX.png
plotHeatmap -m /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/dt_matrix-encode_hesc_actgenes_H2AK119Ub_XY.gz \
		--yMin 0 \
		--yMax 10 \
		-out /proj/snic2020-6-3/SZABOLCS/hESC_minute_XX-XY/results/deeptools/actgenes_H2AK119Ub_XY.png		
		
# plot over bivalent genes		