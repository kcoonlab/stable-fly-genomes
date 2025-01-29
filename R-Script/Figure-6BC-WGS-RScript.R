library(readxl)
library(rmarkdown)
library(dplyr)
library(pagoo)
library(ggrepel) 
library(ggplot2)
library(factoextra)
library(cowplot)

###Load in your df from panaroo or roary
setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-6/R-Import")
p <- roary_2_pagoo("sciuri-Global-Panaroo-RoaryFormat.csv", sep = "__")

###Load in and attach metadata
setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-6/R-Import")
metadata <- read_excel("sciuri-Global-Metadata.xlsx")

names(metadata)[names(metadata) == "Strain"] <- "org"
names(metadata)[names(metadata) == "Origin"] <- "Host"
metadata <- as.data.frame(metadata)
head(metadata)


p$add_metadata(map = "org", metadata)
p$organisms


###Show number of core and accessory genes
# ?pagoo

p$summary_stats

###Display functional information associated with core genes
p$core_clusters


###Calculate # of strains for each host type
table(p$organisms$Host)

###Generate a Rarefaction curve for all samples
Curves2 <- p$gg_curves() + 
  scale_color_manual(values = c("black", "black")) +  # Specify custom colors
  geom_point(alpha = .05, size = 4, color = '#82B446') +  # Set the size of the points
  theme_bw(base_size = 15) + 
  theme_minimal_hgrid(12) +
  theme(legend.position = "none") 
Curves2

Barplot <- p$gg_barplot() + 
  theme_minimal_hgrid(12) + 
  scale_y_continuous(expand = c(0, 0))+ 
  scale_x_continuous(expand = c(0, 0))
Barplot


plot_grid(Curves2, Barplot,labels = "AUTO", ncol = 1) #FigureS4-Fig6-sciuri-pangenome



###Generate a pca from the presence/absence matrix 
pca <- p$pan_pca()

pca_data <- as.data.frame(pca$x)
pca_data$Host <- p$organisms$Host




###Identify clusters via K-means

components <- pca_data[, c("PC1", "PC2")]

#?fviz_nbclust
fviz_nbclust(components, kmeans, method = "wss") # Leveling off at 4 or 5 clusters #Leveling off at 4 or 5 clusters
fviz_nbclust(components, kmeans, method = "silhouette") #peak at 5 cluster

#?kmeans
set.seed(100)
km.res <- kmeans(components, 5, nstart = 50) #use 25 or 50 nstart, 5 represents number of clusters
print(km.res)

fviz_cluster(km.res, data = components,labelsize = 6) #cluttered but shows clusters

pca_data$Cluster <- as.factor(km.res$cluster)
pca_data$Host <- as.factor(pca_data$Host)


custom_colors <- c("Fly" = "#cd3600",                              
                   "Cattle_Manure" = "#648fff", 
                   "Cattle_NonManure" = "#d9abee", 
                   "Bovine_Mastitis" = "#e1e386", 
                   "Other_Animal" = "#c3c7c3",
                   "Other" = "#c3c7c3" )


 



PCA1 <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Host, fill = Host)) +
  geom_point(size = 3, shape = 21, color = "black", stroke = 0.5) +  # Points with black borders
  scale_color_manual(values = custom_colors) +  
  scale_fill_manual(values = custom_colors) +  
  theme_bw(base_size = 15) +
  labs(
       x = paste("PC1 (", round(pca$sdev[1]^2 / sum(pca$sdev^2) * 100, 2), "%)", sep = ""),
       y = paste("PC2 (", round(pca$sdev[2]^2 / sum(pca$sdev^2) * 100, 2), "%)", sep = "")) +
  stat_ellipse(aes(group = Cluster), level = 0.95, alpha = 0.2) +
  theme(legend.title = element_blank()) +
  theme_cowplot(12) + theme(legend.position="none") 

#setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-6/R-Import")
save(PCA1, file = "sciuri-PCA.RData")

selected_data <- pca_data %>%
  select(Host, Cluster)
pca_data %>%count(Host, Cluster)
pca_data %>%count(Cluster)

#write.table(selected_data, file = "sciuriclusters.txt", sep = "\t", row.names = TRUE, quote = FALSE)






####Cluster Analysis
rm(list=ls())
setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-6/R-Import")

library(readxl)
library(ggplot2)
library(reshape2)

clustermap <-read_excel("sciuri-Global-Metadata-Clusters.xlsx", col_names = TRUE)
head(clustermap)



#Simulated P-values chi square with residuals
table_origin_cluster <- table(clustermap$Origin , clustermap$Cluster)
table_origin_cluster <- table(clustermap$Origin_Source_2 , clustermap$Cluster)

print(table_origin_cluster)

chi_sq_test_mc <- chisq.test(table_origin_cluster, simulate.p.value = TRUE, B = 10000)
print(chi_sq_test_mc)
std_residuals_mc <- chi_sq_test_mc$stdres
print(std_residuals_mc)
std_residuals_melt_mc <- melt(std_residuals_mc)



library(ggplot2)
library(reshape2)  # Make sure to load reshape2 if you haven't already
library(pheatmap) 

library(RColorBrewer)
display.brewer.pal(10, name = "Set2")
brewer.pal(n = 8, name = "Set2")


# Create a heatmap with dendrograms
pheatmap(std_residuals_mc, 
         clustering_distance_rows = "euclidean",  # Distance method for rows
         clustering_distance_cols = "euclidean",   # Use Euclidean distance but do not cluster
         clustering_method = "complete",            # Clustering method
         color = colorRampPalette(c("lightskyblue3", "white", "#FC8D62"))(50), # Color gradient
         display_numbers = TRUE,                    # Display residuals
         number_format = "%.2f",                    # Format for numbers
         main = "Heatmap of Standardized Residuals")  # Main title

# Create a heatmap with dendrograms for rows only
heatmap <- pheatmap(std_residuals_mc, 
         clustering_distance_rows = "euclidean",  # Distance method for rows
         clustering_distance_cols = "euclidean",   # Use Euclidean distance but do not cluster
         clustering_method = "complete",            # Clustering method for rows
         color = colorRampPalette(c("#8DA0CB", "white", "#FC8D62"))(50), # Color gradient
         display_numbers = TRUE,                    # Display residuals
         number_format = "%.2f",                    # Format for numbers
         legend = FALSE, 
         cluster_cols = FALSE)  


save(heatmap, file = "sciuri-heatmap-clusters.RData")







