library("tidyverse")
library("data.table")
library("glue")

# paths
result_path = "../results/"

# list bed files intersected with ChromHMM bed
intersections = list.files(result_path, pattern = "_mscaled_chromhmm_int.bed")

# quantify the differentially covered regions at ChromHMM level
chromhmm_abundances = function(intersected_bed, export = TRUE) {
  
  ptm = str_split(intersected_bed, "_")[[1]][1]
  int = fread(glue("{result_path}{intersected_bed}"))
  
  int_aggr = int %>% 
    group_by(V4) %>% 
    count() %>% 
    arrange(desc(n))
  
  bar = ggplot(data = int_aggr, aes(x = reorder(V4, -n), y = n)) +
    geom_bar(stat = "identity", position = "dodge",
             color = "black") +
    theme_minimal() +
    labs(
      title = glue("Abundances of differentially PTM covered regions at ChromHMM level - {ptm}"),
      fill = "experiment"
    ) +
    ylab(label = "# of diff. regions") +
    xlab(label = "ChromHMM") +
    scale_y_continuous(limits = c(0, 4000)) +
    theme(
      axis.text.x = element_text(
        color = "black",
        size = 10,
        angle = 90,
        hjust = 1,
        vjust = 0
      ),
      axis.text.y = element_text(color = "black", size = 14),
      axis.title = element_text(size = 14)
    )
  print(bar)
  
  if(export) {
    ggsave(
      filename = glue("{result_path}{ptm}_diff_chromhmm_abund.png"),
      plot = bar,
      width = 10,
      height = 8,
      dpi = 300,
      device = "png"
    )
  }
 
  return(bar)
  
}

# loop over intersected bed files
sapply(intersections, chromhmm_abundances)







