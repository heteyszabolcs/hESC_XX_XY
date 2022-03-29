library("tidyverse")
library("data.table")
library("glue")
library("edgeR")
library("EnhancedVolcano")

# turn off scientific notations and warnings
options(scipen = 999)
options(warn = -1)

# folders
result_folder = "../results/"
data_folder = "../data/"

# read count estimator
fragment_length = 150
bin_size = 2000
# read count estimator
read_est = bin_size / fragment_length

# input normalized data and genotype info
input_norm = "input_normalized_chromhmm_2kbp.tsv"
chrom_data = "chrom_info.txt"
input_norm = fread(glue("{result_folder}{input_norm}"))
chrom_data = fread(glue("{data_folder}{chrom_data}"))

diff_bind_edgeR = function(input_norm, ptm = NULL, bin_size) {
  # estimate read counts
  read_counts = input_norm %>% mutate_at(vars(-seqnames,-start,-end,-width,-strand), ~ . * read_est)
  
  # create design
  marks = character()
  samples = character()
  
  for (column in colnames(read_counts)[6:ncol(read_counts)]) {
    m = str_split(column, "_")[[1]][1]
    s = str_split(column, "_")[[1]][2]
    
    marks = c(marks, m)
    samples = c(samples, s)
  }
  
  design = tibble(
    column = colnames(read_counts)[6:ncol(read_counts)],
    "mark" = marks,
    "sample" = samples
  )
  design = design %>% left_join(., chrom_data, by = c("sample" = "sample"))
  
  # optimize read count table
  read_counts[is.na(read_counts)] = 0
  read_counts = read_counts %>% mutate_all(function(x)
    ifelse(is.infinite(x), 0, x))
  ranges = read_counts %>% unite(., col = "rowname", seqnames:end, sep = "_") %>% pull(rowname)
  read_counts = read_counts %>% select(-seqnames,-start,-end,-width,-strand)
  read_counts = as.matrix(read_counts)
  rownames(read_counts) = ranges
  
  print("edgeR TMM normalization")
  # edgeR with TMM
  dge = DGEList(counts = read_counts, group = design$status)
  dge = calcNormFactors(dge)
  
  # filtering out underrepresented regions (cpm based)
  cps = cpm(dge)
  k = rowSums(cps > 1) >= 2
  dge = dge[k, ]
  
  # create design matrix for XX - XY comparison
  if (is.null(ptm)) {
    group = design$status
    design_mat = model.matrix(~ 0 + group, data = dge$samples)
    colnames(design_mat) = levels(dge$samples$group)
    design_mat
  } else {
    design = design %>% filter(mark == ptm) # consider epigenetic mark
    samples = list(design$column)
    group = design$status
    design_mat = model.matrix(~ 0 + group, data = samples)
    colnames(design_mat) = levels(dge$samples$group)
    rownames(design_mat) = design$column
    dge$samples = dge$samples[rownames(design_mat),]
    dge$counts = dge$counts[, rownames(design_mat)]
  }
  
  print("edgeR GLM Common dispersion")
  # estimate dispersion
  dge = estimateGLMCommonDisp(dge, design_mat)
  print("edgeR GLM Trended dispersion")
  dge = estimateGLMTrendedDisp(dge, design_mat)
  dge = estimateGLMTagwiseDisp(dge, design_mat)
  
  print("edgeR fc table")
  # quasi-likelihood fitting
  fit = glmQLFit(dge, design_mat)
  # quasi-likelihood F-test. XX vs. XY samples
  contrast = makeContrasts(XX - XY, levels = design_mat)
  XX_XY = glmQLFTest(fit, contrast = contrast)
  
  options(scipen = 0)
  xx_xy_fc = XX_XY$table
  xx_xy_fc = xx_xy_fc[order(xx_xy_fc$PValue),]
  
  # exclude chrX, chrY
  aut_chr_ranges = rownames(xx_xy_fc)[!grepl("chrX|chrY", rownames(xx_xy_fc))]
  xx_xy_fc = xx_xy_fc[aut_chr_ranges, ]
  
  if (is.null(ptm)) {
    write.table(
      xx_xy_fc,
      file = glue(
        "{result_folder}XX_XY_{as.character(bin_size / 1000)}kbp_fc_table.tsv"
      ),
      quote = FALSE,
      row.names = TRUE
    )
  } else {
    write.table(
      xx_xy_fc,
      file = glue(
        "{result_folder}{ptm}_XX_XY_{as.character(bin_size / 1000)}kbp_fc_table.tsv"
      ),
      quote = FALSE,
      row.names = TRUE
    )
    
  }
  
  # volcano plot
  png(
    file = glue(
      "{result_folder}XX_XY_{as.character(bin_size / 1000)}kbp_{ptm}_fc_table.png"
    ),
    width = 10,
    height = 10,
    units = 'in',
    res = 300
  )
  volc = EnhancedVolcano(
    xx_xy_fc,
    lab = rownames(xx_xy_fc),
    labSize = 2.5,
    title = glue("XX - XY, {ptm}"),
    pCutoff = 0.05,
    FCcutoff = 2.0,
    colAlpha = 0.5,
    legendPosition = "right",
    x = 'logFC',
    y = 'PValue',
    subtitle = "pCutoff: 0.05, FC: 2",
    col = c('grey', 'grey', 'grey', '#9ecae1')
  )
  print(volc)
  dev.off()
  
  return(xx_xy_fc)
  
}


# loop over
ptms = c("H3K4me3", "H3K36me3", "H3K4me1", "H3K27me3", "H3K27Ac", "H2AK119Ub")
lapply(ptms, diff_bind_edgeR, input_norm = input_norm, bin_size = bin_size)