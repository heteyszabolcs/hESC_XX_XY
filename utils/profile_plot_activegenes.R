library("data.table")
library("wigglescout")
library("GenomicRanges")
library("rtracklayer")
library("RColorBrewer")

# create info table
source("meta.R")

# ChromHmm bed file
genes = "../data/hg38/ENCODE_hESC_active_genes.gtf"
genes = import(genes, format = "GTF")
result_folder = "../results/"

# profile plot over hg38 gene set
profile_plot = function(ptm = "H3K36me3") {
  select_samples = function(ptm, gender) {
    subset = info %>% filter(status == gender) %>% filter(mark == ptm) %>% arrange(filename) %>% pull(filename)
    return(subset)
  }
  
  print(ptm)
  
  XX = select_samples(ptm = ptm, gender = "XX")
  XX_annot = character()
  for (sample in XX) {
    temp = str_split(sample, "../data/bigwig/")[[1]][2]
    temp1 = str_split(temp, "_")[[1]][1]
    temp2 = str_split(temp, "_")[[1]][2]
    label = glue("{temp1}_{temp2}_XX")
    XX_annot = c(XX_annot, label)
  }
  
  XY = select_samples(ptm = ptm, gender = "XY")
  XY_annot = character()
  for (sample in XY) {
    temp = str_split(sample, "../data/bigwig/")[[1]][2]
    temp1 = str_split(temp, "_")[[1]][1]
    temp2 = str_split(temp, "_")[[1]][2]
    label = glue("{temp1}_{temp2}_XY")
    XY_annot = c(XY_annot, label)
  }
  
  p = plot_bw_profile(
    c(XX, XY),
    loci = genes,
    labels = c(XX_annot, XY_annot),
    colors = c(brewer.pal(n = 4, name = "Reds"), brewer.pal(n = 4, name = "Blues")),
    mode = "start"
  ) + coord_cartesian(ylim = c(0, 10))
  
  ggsave(
    plot = p,
    filename = glue("{result_folder}{ptm}_activeg_profileplot.png"),
    width = 10,
    height = 8,
    dpi = 500,
    device = "png"
  )
  
}

# loop through epigenetic marks
marks = unique(info$mark)
marks = marks[!str_detect(marks, "Input")]

sapply(marks, profile_plot)
