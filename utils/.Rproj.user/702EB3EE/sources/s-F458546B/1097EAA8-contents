library("tidyverse")
library("data.table")
library("wigglescout")
library("GenomicRanges")
library("rtracklayer")

# create info table
source("meta.R")

# ChromHmm bed file
genes = "../data/hg38/genes.gtf"
genes = import(genes, format = "GTF")
result_folder = "../results/"

x = bw_loci("../data/bigwig/H2AK119Ub_1001_pooled.hg38.scaled.bw", 
            bg_bwfiles = "../data/bigwig/Input_1001_pooled.hg38.unscaled.bw", loci = genes)
y = as.data.frame(genes)
x_df = as.data.frame(x)
x_annot = x_df %>% inner_join(., y, c("seqnames" = "seqnames", "start" = "start", "end" = "end"))

example = x_annot %>% select(seqnames, start, end, starts_with("H2AK"), gene_name)
