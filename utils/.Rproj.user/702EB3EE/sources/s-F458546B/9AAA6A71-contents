library("tidyverse")
library("data.table")
library("wigglescout")
library("GenomicRanges")
library("rtracklayer")

# create info table
source("meta.R")

hmm = "../data/bed/ChromHMM_E008_15_coreMarks_hg38lift_noblock_fullnames.bed"
hmm = import(hmm)
result_folder = "../results/"

# generate log2 fold change between XX (female) and XY (male) epigenetic markers and 
# visualize by boxplot
logfc_distr = function(ptm,
                       bin = 2000,
                       save = TRUE) {
  print(ptm)
  
  select_samples = function(ptm, gender) {
    subset = info %>% filter(status == gender) %>% filter(mark == ptm) %>% arrange(filename) %>% pull(filename)
    return(subset)
  }
  
  
  logfc = bw_bins(
    select_samples(ptm = ptm, gender = "XX"),
    bg_bwfiles = select_samples(ptm = ptm, gender = "XY"),
    bin_size = bin,
    selection = hmm, # select chromhmm regions
    genome = "hg38",
    norm_mode = "log2fc"
  )
  
  logfc = as_tibble(logfc)
  logfc = logfc %>% select(-seqnames, -start, -end, -width, -strand) %>%
    pivot_longer(starts_with(ptm),
                 names_to = "sample",
                 values_to = "log2fc") %>%
    arrange(sample) %>%
    separate(sample, sep = "_pooled.hg38.scaled", into = c("sample", "rest")) %>%
    select(-rest) %>%
    na.omit() %>%
    filter_if(~ is.numeric(.), all_vars(!is.infinite(.)))
  
  
  p = ggplot(logfc, aes(x = reorder(sample, -log2fc),
                        y = log2fc,
                        fill = sample)) +
    geom_boxplot() +
    theme_minimal() +
    labs(
      title = glue(
        "{ptm} log2 fold change distribution (XX to XY), bin size: {as.character(bin/1000)} kbp"
      ),
      fill = "sample"
    ) +
    ylim(-20, 20) +
    ylab(label = glue("{ptm} log2 fold change")) +
    xlab(label = "") +
    scale_fill_brewer(palette = "Reds") +
    theme(
      axis.text.x = element_text(
        color = "black",
        size = 15,
        angle = 45,
        hjust = 1,
        vjust = 1
      ),
      axis.text.y = element_text(color = "black", size = 14),
      axis.title = element_text(size = 14)
    ) +
    stat_compare_means(label.y = 20)
  
  if (save) {
    ggsave(
      plot = p,
      filename = glue(
        "{result_folder}{ptm}_{as.character(bin/1000)}kbp_XX-to-XY_chromhmm_log2fc_boxp.png"
      ),
      width = 10,
      height = 8,
      dpi = 500,
      device = "png"
    )
  }
  
}

# exclude input and loop through
info_wo_input = info %>% filter(mark != "Input")


