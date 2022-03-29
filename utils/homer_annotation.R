library("tidyverse")
library("data.table")
library("glue")

result_folder = "../results/bedtools/sign_diff_regions/"
bed_file = "H2AK119Ub_XX_XY_2kbp_fc_table"
bed_data = fread(glue("{result_folder}{bed_file}.bed"), header = FALSE, quote = FALSE)
system(glue("annotatePeaks.pl {result_folder}{bed_file}.bed hg38 > {result_folder}{bed_file}_annot.tsv"))

