library(pagoo)
library(ggrepel) 
library(ggplot2)
library(factoextra)
library(readxl)
library(dplyr)
library(cowplot)


setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-3/Supporting-Files/Pangenome-R")
p <- roary_2_pagoo("Escherichia-Global-Panaroo-RoaryFormat.csv", sep = "__")

setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-3/Supporting-Files/Metadata")
metadata <- read_excel("Escherichia-Global-Metadata.xlsx")
names(metadata)[names(metadata) == "Strain"] <- "org"
names(metadata)[names(metadata) == "Origin"] <- "Host"
names(metadata)[names(metadata) == "MASH_Phylogroup"] <- "phylogroup"

metadata <- as.data.frame(metadata)
head(metadata)

p$add_metadata(map = "org", metadata)


p$summary_stats

###Display functional information associated with core genes
p$core_clusters


###Calculate # of strains for each host type
table(p$organisms$Host)
table(p$organisms$phylogroup)

###Generate a Rarefaction curve for all samples
Curves <- p$gg_curves() + 
  geom_point() + 
  facet_wrap(~Category, scales = 'free_y') + 
  theme_bw(base_size = 15) + 
  scale_color_brewer(palette = "Accent") +
  theme_minimal_hgrid(12) +
  theme(legend.position="none") 
Curves

Barplot <- p$gg_barplot() + 
  theme_minimal_hgrid(12) + 
  scale_y_continuous(expand = c(0, 0))+ 
  scale_x_continuous(expand = c(0, 0))
Barplot

plot_grid(Curves, Barplot,labels = "AUTO", ncol = 1) #SupportingFigure_Pangenome-Curves-WGS_Analysis


Curves2 <- p$gg_curves() + 
  scale_color_manual(values = c("black", "black")) +  # Specify custom colors
  geom_point(alpha = .05, size = 4, color = '#82B446') +  # Set the size of the points
  theme_bw(base_size = 15) + 
  theme_minimal_hgrid(12) +
  theme(legend.position = "none") 
Curves2




##Generate a pie chart of core and shell genes 
p$gg_pie() + theme_bw(base_size = 15) +
  scale_fill_brewer(palette = "Blues") +
  scale_x_discrete(breaks = c(0, 25, 50, 75)) + labs(subtitle = "D") +
  theme(legend.position = "bottom", legend.title = element_blank(),
        legend.text = element_text(size = 10),
        legend.margin = margin(0, 0, 13, 0), legend.box.margin = margin(0, 0, 5, 0),
        axis.title = element_blank(), axis.ticks = element_blank(),
        axis.text.x = element_blank())



###Generate a pca from the presence/absence matrix 
pca <- p$pan_pca()
pca_data <- as.data.frame(pca$x)
pca_data$Host <- p$organisms$Host
unique(pca_data$Host)

components <- pca_data[, c("PC1", "PC2")]
fviz_nbclust(components, kmeans, method = "wss") # Leveling off at 4 or 5 clusters #Leveling off at 4
fviz_nbclust(components, kmeans, method = "silhouette") #peak at 3 cluster


#?kmeans
set.seed(100)
km.res <- kmeans(components, 4, nstart = 50) #use 25 or 50 nstart, n represents number of clusters
print(km.res)

fviz_cluster(km.res, data = components,labelsize = 6) #cluttered but shows clusters

pca_data$Cluster <- as.factor(km.res$cluster)
pca_data$Host <- as.factor(pca_data$Host)

host_colors <- c("Fly" = "#cd3600", "Manure" = "#648fff","WVDL" = "#e1e386",
                   "Mastitis" = "#e1e386",
                   "FlyNCBI" = "#f5abab",
                   "Pathogen" = "#c3c7c3",
                   "ECOR" = "#c3c7c3" )



PCA1 <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Host, fill = Host)) +
  geom_point(size = 3, shape = 21, color = "black", stroke = 0.5) +  # Points with black borders
  scale_color_manual(values = host_colors) +  
  scale_fill_manual(values = host_colors) +  
  theme_bw(base_size = 15) +
  labs(title = " ",
       x = paste("PC1 (", round(pca$sdev[1]^2 / sum(pca$sdev^2) * 100, 2), "%)", sep = ""),
       y = paste("PC2 (", round(pca$sdev[2]^2 / sum(pca$sdev^2) * 100, 2), "%)", sep = "")) +
  stat_ellipse(aes(group = Cluster), level = 0.95, alpha = 0.2) +
  theme(legend.title = element_blank())  +
  theme_cowplot(12) + theme(legend.position="none") 


pca_data$phylogroup <- p$organisms$phylogroup
phylogroup_colors <- c("A" = "#cc6677", 
                       "B1" = "#117733",
                       "D" = "#332288",
                       "E" = "orange",
                       "B2" = "#44aa99",
                       "F" = "#c3c7c3",
                       "C" = "#c3c7c3",
                       "cladeI"="#c3c7c3")


PCA2 <- ggplot(pca_data, aes(x = PC1, y = PC2, color = phylogroup, fill = phylogroup)) +
  geom_point(size = 3, shape = 21, color = "black", stroke = 0.5) +  # Points with black borders
  scale_color_manual(values = phylogroup_colors) +  
  scale_fill_manual(values = phylogroup_colors) +  
  theme_bw(base_size = 15) +
  labs(title = " ",
       x = paste("PC1 (", round(pca$sdev[1]^2 / sum(pca$sdev^2) * 100, 2), "%)", sep = ""),
       y = paste("PC2 (", round(pca$sdev[2]^2 / sum(pca$sdev^2) * 100, 2), "%)", sep = "")) +
  stat_ellipse(aes(group = Cluster), level = 0.95, alpha = 0.2) +
  theme(legend.title = element_blank())  +
  theme_cowplot(12) + theme(legend.position="none") 


B <- plot_grid(PCA1, PCA2,labels = "AUTO", ncol = 2) 



plot_grid(Curves2, B, labels = "AUTO", ncol = 1) 

#FigureS1-Fig3-Escherichia-Global-Pangenome-WGS_Analysis
bottom_row <- plot_grid(PCA1, PCA2,labels = c('B', 'C'), label_size = 12)
plot_grid(Curves2, bottom_row, labels = c('A', ''), ncol = 1,label_size = 12) 






pca_data %>% count(Host, Cluster)
pca_data %>%count(Cluster)


selected_data <- pca_data %>%
  select(Host, Cluster)


