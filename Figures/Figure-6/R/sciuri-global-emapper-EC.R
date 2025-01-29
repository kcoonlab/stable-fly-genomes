library(dplyr)
library(tidyr)
library(ggplot2)
library(tidyverse)
library(readxl)
library(xlsx)
library(reshape2)  

setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-6/R-Import")



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
setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-6/R-Import")
clustermap <-read_excel("sciuri-Global-Clustermap.xlsx", col_names = TRUE) 
head(clustermap)
table(clustermap$cluster) ####Counts of each cluster




all_data_cluster <- all_data %>%
  left_join(clustermap, by = "strain") %>%
  select(cluster  , everything())  


###Read in Kegg Modules####
library(KEGGREST)
listDatabases()

kegg_enzyme_info <- keggList("enzyme")
str(kegg_enzyme_info)

kegg_enzyme_info <- data.frame(
  EC = names(kegg_enzyme_info),    # KEGG module IDs
  Description = as.character(kegg_enzyme_info),  # Functional descriptions
  stringsAsFactors = FALSE                   # Avoid factors for easier merging
)



###Chi Square####

all_data_separated <- all_data_cluster %>%
  mutate(EC = ifelse(EC == "-", NA, EC)) %>%
  separate_rows(EC, sep = ",")  



table_kegg_cluster_unique <- all_data_separated %>%
  group_by(cluster, EC) %>%
  summarise(unique_strains = n_distinct(strain), .groups = 'drop') %>%
  spread(key = cluster, value = unique_strains, fill = 0)





# Display the modified contingency table
print(table_kegg_cluster_unique)

table_kegg_cluster_final <- as.table(as.matrix(table_kegg_cluster_unique[, -1]))
rownames(table_kegg_cluster_final) <- table_kegg_cluster_unique$EC

# Print the final contingency table
print(table_kegg_cluster_final)

chi_sq_test_mc <- chisq.test(table_kegg_cluster_final, simulate.p.value = TRUE, B = 10000)

print(chi_sq_test_mc)
#X-squared = 6740.6, df = NA, p-value = 9.999e-05

# Get the standardized residuals
std_residuals_mc <- chi_sq_test_mc$stdres

# Print the standardized residuals
print(std_residuals_mc)

std_residuals_df <- as.data.frame(std_residuals_mc)
head(std_residuals_df)
colnames(std_residuals_df)[colnames(std_residuals_df) == "Var1"] <- "EC"

std_residuals_df_info <- std_residuals_df %>%
  left_join(kegg_enzyme_info, by = "EC")

filtered_df <- std_residuals_df_info[std_residuals_df_info$Freq >= 2 | std_residuals_df_info$Freq <= -2, ]
head(filtered_df)


#Merge the filtered_df with residuals to the 

head(std_residuals_df_info)

head(table_kegg_cluster_unique)




std_residuals_df_info <- std_residuals_df_info %>%
  dplyr::rename(Cluster = "Var2")
colnames(std_residuals_df_info)



std_residuals_wide <- std_residuals_df_info %>%
  select(EC, Cluster, Freq, Description) %>% # Select only relevant columns
  pivot_wider(names_from = Cluster, values_from = Freq)



merged_df <- table_kegg_cluster_unique %>%
  left_join(std_residuals_wide, by = "EC")


head(merged_df)


#setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-6/Supporting-Files/R-export")
#write.xlsx(merged_df, 'sciuri-EC-Residuals.xlsx') #Used this table to make the sciuri-EC-Residuals-formatted to import for Fig 6D and also for supp table 

