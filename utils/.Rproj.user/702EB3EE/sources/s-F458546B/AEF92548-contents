library("tidyverse")
library("data.table")
library("wigglescout")
library("GenomicRanges")
library("rtracklayer")
library("glue")

# create info table
source("meta.R")

# paths
bigwig_path = "../data/bigwig/"
result_path = "../results/"

# bivalent promoters,Court et al. 2017
bivalents = "../data/bed/Bivalent_Court2017.hg38.bed"
bivalents = import(bivalents)

# resolution
bin = 10000

# normalize to the corresponding input
input_normalization = function(mark = "../data/bigwig/H3K4me1_1001_pooled.hg38.scaled.bw",
                               input = "../data/bigwig/Input_1001_pooled.hg38.unscaled.bw",
                               bin_size = bin) {
  bw_bins(
    mark,
    bg_bwfiles = input,
    bin_size = bin,
    selection = bivalents,
    genome = "hg38"
  )
}

# create a tibble with the input normalize values
create_edgeR_input = function(mark, bin_size = bin) {
  sample = str_split(mark, bigwig_path)[[1]][2]
  sample = str_split(sample, "_")[[1]][2]
  input = bigwigs_inputs[grep(sample, bigwigs_inputs)]
  
  print(glue("bigwig: {mark}"))
  print(glue("sample: {sample} - input: {input}"))
  
  norm = input_normalization(mark = mark,
                             input = input,
                             bin_size = bin_size)
  norm = as.data.frame(norm)
  norm = norm %>% select(-seqnames,-start,-end,-width,-strand)
  
  return(norm)
}

# extract genomic ranges (first 5 columns) for a given bin size
get_ranges = function(mark = "../data/bigwig/H3K4me1_1001_pooled.hg38.scaled.bw",
                      input = "../data/bigwig/Input_1001_pooled.hg38.unscaled.bw",
                      bin_size = bin) {
  df = input_normalization(mark = mark,
                           input = input,
                           bin_size = bin)
  df = as.data.frame(df)
  ranges = df %>% select(seqnames, start, end, width, strand)
  
  return(ranges)
  
}

# bigwigs_inputs
bigwigs_marks

# loop through epigenetic data
input_norm_data = lapply(bigwigs_marks, create_edgeR_input)
input_norm_data = bind_cols(input_norm_data)

ranges = get_ranges()
input_norm_data = cbind(ranges, input_norm_data)

# save
write_tsv(
  input_norm_data,
  glue(
    "{result_path}input_normalized_bivalents_{as.character(bin / 1000)}kbp.tsv"
  )
)
