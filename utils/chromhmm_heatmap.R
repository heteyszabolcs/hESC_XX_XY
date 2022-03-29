library("data.table")
library("wigglescout")
library("GenomicRanges")
library("rtracklayer")

# create info table
source("meta.R")

# ChromHmm bed file
hmm = "../data/bed/ChromHMM_E008_15_coreMarks_hg38lift_noblock_fullnames.bed"
hmm = import(hmm)
result_folder = "../results/"

hmm_hm = function(ptm = "H3K36me3") {
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
  
  hm = plot_bw_loci_summary_heatmap(c(XX, XY),
                                    labels = c(XX_annot, XY_annot),
                                    loci = hmm)
  
  ggsave(
    plot = hm,
    filename = glue("{result_folder}{ptm}_ChromHMM_heatmap.png"),
    width = 10,
    height = 8,
    dpi = 500,
    device = "png"
  )
  
}

# loop through epigenetic marks
marks = unique(info$mark)
marks = marks[!str_detect(marks, "Input")]

sapply(marks, hmm_hm)
