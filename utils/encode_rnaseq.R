library("tidyverse")
library("data.table")
library("glue")
library("biomaRt")

# paths
encode = "../data/ENCODE/"
hg38 = "../data/hg38/"

# hg38
genes = fread(glue("{hg38}genes.gtf"))

# list ENCODE hESC gene quantifications
list.files(encode, full.names = TRUE)

# upper quantile
quantile = 0.99

# read ENCODE hESC data and filter the highly expressing genes
# source: https://www.encodeproject.org/search/?type=Experiment&searchTerm=hESC&assay_title=total+RNA-seq
expr1 = fread(glue("{encode}hESC_RNASeq_gene_quant_ENCFF174OMR_rep1.tsv"))
expr1 = expr1 %>%
  dplyr::filter(TPM >= quantile(TPM, quantile)) %>%
  arrange(desc(TPM)) %>%
  dplyr::filter(str_detect(gene_id, "ENSG")) %>%
  separate(gene_id, into = c("ENSEMBL_ID", ".")) %>%
  pull(ENSEMBL_ID) %>% unique()

expr2 = fread(glue("{encode}hESC_RNASeq_gene_quant_ENCFF910OBU_rep2.tsv"))
expr2 = expr2 %>%
  dplyr::filter(TPM >= quantile(TPM, quantile)) %>%
  arrange(desc(TPM)) %>%
  dplyr::filter(str_detect(gene_id, "ENSG")) %>%
  separate(gene_id, into = c("ENSEMBL_ID", ".")) %>%
  pull(ENSEMBL_ID) %>% unique()

active_genes = tibble(ENSEMBL_ID = intersect(expr2, expr1))

# biomaRt annotation
ensembl = useEnsembl(biomart = "genes", dataset = "hsapiens_gene_ensembl")
active_genes = getBM(
  attributes = c('ensembl_gene_id', 'hgnc_symbol'),
  filters = 'ensembl_gene_id',
  values = active_genes$ENSEMBL_ID,
  mart = ensembl
)

# modify gtf file
genes_mod = genes %>% 
  separate(V9, into = c("temp", "rest"), sep = "\"; gene_name", remove = FALSE) %>%
  separate(temp, into = c("temp", "gene_symbol"), sep = "gene_id \"") %>% 
  dplyr::select(-temp, -rest) %>% 
  filter(gene_symbol %in% active_genes$hgnc_symbol) %>% 
  dplyr::select(-gene_symbol)
  
# export
write.table(genes_mod, glue("{hg38}ENCODE_hESC_active_genes.gtf"), col.names = FALSE, 
            quote = FALSE, 
            row.names = FALSE)

# export to bed
bed = genes_mod %>% dplyr::select(V1, V4, V5)
write_tsv(bed, glue("{hg38}ENCODE_hESC_active_genes.bed"), col_names = FALSE)




