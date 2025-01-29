library(dplyr)
library(tidyr)
library(ggplot2)
library(tidyverse)
library(readxl)
library(xlsx)
library(reshape2)  

setwd("D:/WGS_Analysis/emapper/NCBI_sciuri/Import")

###Read in eggnog emapper files####
files <- list.files(pattern = "_emapper.tsv$", full.names = TRUE)

read_and_label <- function(file) {
  if (grepl("Fly", file)) {
    origin <- "Fly"
  } else if (grepl("Manure", file)) {
    origin <- "Manure"
  } else if (grepl("NCBI", file) || grepl("GCA", file)) {
    origin <- "GCA"
  } else {
    origin <- NA
  }
  if (grepl("GCA_", file)) {
    # Keep the GCA prefix
    strain <- sub(".*(GCA_[^_]+)_emapper.tsv$", "\\1", file)
  } else {
    strain <- sub(".*_([^_]+)_emapper.tsv$", "\\1", file)
  }
  data <- read.csv(file, sep = "\t", header = TRUE)
  data <- data %>%
    mutate(origin = origin, strain = strain) %>%
    select(origin, strain, everything()) 
  return(data)
}

all_data <- map_df(files, read_and_label)
head(all_data)

unique(all_data$strain)

###Add cluster information####
library(readxl)
setwd("D:/WGS_Analysis/emapper/NCBI_sciuri")
clustermap <-read_excel("clustermap.xlsx", col_names = TRUE)
head(clustermap)

all_data_cluster <- all_data %>%
  left_join(clustermap, by = "strain") %>%
  select(cluster  , everything())  

###Read in Kegg Modules####
library(KEGGREST)
listDatabases()

kegg_ko_info <- keggList("ko")
str(kegg_ko_info)

kegg_ko_df <- data.frame(
  KEGG_ko = names(kegg_ko_info),    # KEGG module IDs
  Description = as.character(kegg_ko_info),  # Functional descriptions
  stringsAsFactors = FALSE                   # Avoid factors for easier merging
)





###Chi Square####

all_data_separated <- all_data_cluster %>%
  mutate(KEGG_ko = ifelse(KEGG_ko == "-", NA, KEGG_ko)) %>%
  separate_rows(KEGG_ko, sep = ",")  # This will create a row for each module


all_data_separated$KEGG_ko <- sub("ko:", "", all_data_separated$KEGG_ko)
head(all_data_separated)




table_kegg_cluster_unique <- all_data_separated %>%
  group_by(cluster, KEGG_ko) %>%
  summarise(unique_strains = n_distinct(strain), .groups = 'drop') %>%
  spread(key = cluster, value = unique_strains, fill = 0)





# Display the modified contingency table
print(table_kegg_cluster_unique)

table_kegg_cluster_final <- as.table(as.matrix(table_kegg_cluster_unique[, -1]))
rownames(table_kegg_cluster_final) <- table_kegg_cluster_unique$KEGG_ko

# Print the final contingency table
print(table_kegg_cluster_final)

chi_sq_test_mc <- chisq.test(table_kegg_cluster_final, simulate.p.value = TRUE, B = 10000)

print(chi_sq_test_mc)

# Get the standardized residuals
std_residuals_mc <- chi_sq_test_mc$stdres

# Print the standardized residuals
print(std_residuals_mc)

std_residuals_df <- as.data.frame(std_residuals_mc)
head(std_residuals_df)
colnames(std_residuals_df)[colnames(std_residuals_df) == "Var1"] <- "KEGG_ko"

std_residuals_df_info <- std_residuals_df %>%
  left_join(kegg_ko_df, by = "KEGG_ko")


std_residuals_df_info2 <- std_residuals_df_info %>% drop_na()

head(std_residuals_df_info2)

filtered_df <- std_residuals_df_info2[std_residuals_df_info2$Freq >= 2 | std_residuals_df_info2$Freq <= -2, ]
head(filtered_df)

unique(filtered_df$KEGG_ko)


head(std_residuals_df_info)


wide_residuals <- std_residuals_df_info %>%
  pivot_wider(names_from = Var2,  # The column with cluster information
              values_from = Freq)  # The column with frequency values

wide_residuals_2 <- wide_residuals %>%
  left_join(table_kegg_cluster_unique, by = "KEGG_ko")
#write.xlsx(wide_residuals_2, 'ResidualsDataframe.xlsx')





setwd("C:/Users/asomm/OneDrive/Desktop/Documents/WGS_StableFly_Analysis/RExport/Emapper_Comparisons/sciuri")
#write.xlsx(filtered_df, 'Sciuri_SignificantKOs.xlsx')
#write.xlsx(std_residuals_df_info, 'Sciuri_ALL_KOs.xlsx')
#write.xlsx(table_kegg_cluster_unique, 'table_kegg_cluster_unique.xlsx')

pathways <- keggList("pathway")
pathway_df <- data.frame(
  KEGG_Pathway = names(pathways),
  Description = as.character(pathways),
  stringsAsFactors = FALSE
)
head(pathway_df)


head(filtered_df)

KEGG_kopathway <- all_data_separated  %>%select(KEGG_ko, KEGG_Pathway)
KEGG_kopathway_2 <- unique(KEGG_kopathway) %>% na.omit(KEGG_kopathway_2)
head(KEGG_kopathway_2)

library(dplyr)
library(tidyr)

# Assuming KEGG_kopathway_2 is your tibble
KEGG_kopathway_3 <- KEGG_kopathway_2 %>%
  separate_rows(KEGG_Pathway, sep = ",") %>%
  filter(grepl("^map", KEGG_Pathway)) %>%
  distinct()

head(KEGG_kopathway_3)
head(pathway_df)


merged_KEGGPathway <- pathway_df %>% left_join(KEGG_kopathway_3, by = "KEGG_Pathway")
merged_KEGGPathway_cleaned <- merged_KEGGPathway  %>% na.omit(merged_KEGGPathway)
head(merged_KEGGPathway_cleaned)


final_df <- filtered_df %>%
  left_join(merged_KEGGPathway_cleaned, by = "KEGG_ko")
setwd("C:/Users/asomm/OneDrive/Desktop/Documents/WGS_StableFly_Analysis/RExport/Emapper_Comparisons/sciuri")
write.xlsx(final_df, 'Sciuri_SignificantKOs_withPathway.xlsx')


