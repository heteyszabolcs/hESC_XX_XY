library("tidyverse")
library("data.table")
library("wigglescout")
library("glue")

bigwig_path = "../data/bigwig/"
chrom_path = "../data/chrom_info.txt"

bigwigs = list.files(bigwig_path, full.names = TRUE)
chrom_info = fread(chrom_path)

# collect epigenetic marks
bigwigs_marks = bigwigs[grep("_pooled.hg38.unscaled.bw", bigwigs)]

# collect inputs
bigwigs_inputs = bigwigs[grep("Input", bigwigs)]
bigwigs_inputs = bigwigs_inputs[grep("pooled", bigwigs_inputs)]

bigwigs_all = c(bigwigs_marks, bigwigs_inputs)


marks = character()
samples = character()
pools = character()
filenames = character()

for(bigwig in bigwigs_all) {
  name = str_split(bigwig, bigwig_path)[[1]][2]
  marks = c(marks, str_split(name, "_")[[1]][1])
  samples = c(samples, str_split(name, "_")[[1]][2])
  pools = c(pools, str_split(str_split(name, "_")[[1]][3], "\\.")[[1]][1])
  filenames = c(filenames, bigwig)
}

info = tibble("mark" = marks, "sample" = samples, "pool" = pools, "filename" = filenames)
info = info %>% left_join(., chrom_info, by = c("sample" = "sample"))



