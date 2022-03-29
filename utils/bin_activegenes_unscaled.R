library("tidyverse")
library("data.table")
library("glue")
library("edgeR")
library("EnhancedVolcano")
library("GenomicRanges")
library("rtracklayer")
library("wigglescout")

# create info table
source("meta_unscaled.R")

# turn off scientific notations and warnings
options(scipen = 999)
options(warn = -1)

# folders
result_folder = "../results/edgeR/"
data_folder = "../data/"

# ENCODE hESC total RNA-Seq highly expressed genes
actives = "../data/hg38/ENCODE_hESC_active_genes.bed"
actives = import(actives)

# minute scaling factors
sf = fread(glue("{data_folder}minute_pooled_scalinginfo.txt"))

# read count estimator
fragment_length = 150
bin = 10000
# read count estimator
read_est = bin / fragment_length

# we do not normalize to the corresponding input here rather we bin the bigwigs
binning = function(mark = "../data/bigwig/H3K4me1_1001_pooled.hg38.scaled.bw",
                   bin_size = bin) {
  bw_bins(mark,
          bin_size = bin_size,
          selection = actives,
          genome = "hg38")
}

# create a tibble with the input normalize values
create_edgeR_input = function(mark, bin_size = bin) {
  
  sample = str_split(mark, bigwig_path)[[1]][2]
  sample = str_split(sample, "_")[[1]][2]
  
  print(glue("bigwig: {mark}"))
  print(glue("sample: {sample}"))
  
  binned = binning(mark = mark, bin_size = bin_size)
  binned = as.data.frame(binned)
  binned = binned %>% select(-seqnames, -start, -end, -width, -strand)
  
  return(binned)
}

# extract genomic ranges (first 5 columns) for a given bin size
get_ranges = function(mark = "../data/bigwig/H3K4me1_1001_pooled.hg38.scaled.bw", 
                      bin_size = bin) {
  df = binning(mark = mark, bin_size = bin_size)
  df = as.data.frame(df)
  ranges = df %>% select(seqnames, start, end, width, strand)
  
  return(ranges)
  
}

# bigwigs_inputs
bigwigs_marks

# loop through epigenetic data
binned_data = lapply(bigwigs_marks, create_edgeR_input)
binned_data = bind_cols(binned_data)

ranges = get_ranges()
binned_data = cbind(ranges, binned_data)

# save
write_tsv(binned_data, glue("{result_folder}activegenes_unscaled_{as.character(bin / 1000)}kbp.tsv"))

