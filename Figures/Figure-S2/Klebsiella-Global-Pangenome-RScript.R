library(pagoo)
library(ggrepel) 
library(ggplot2)
library(factoextra)
library(readxl)
library(dplyr)
library(cowplot)

setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-5/Supporting-Files/Pangenome-R")
p <- roary_2_pagoo("Klebsiella-Global-Panaroo-RoaryFormat.csv", sep = "__")

setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-5/Supporting-Files/Metadata")
metadata <- read_excel("Klebsiella-Global-Metadata.xlsx")

#metadata <- read_excel("KP1NCBI_metadata.xlsx")
names(metadata)[names(metadata) == "Strain"] <- "org"
names(metadata)[names(metadata) == "Origin"] <- "Host"
metadata <- as.data.frame(metadata)
head(metadata)




p$add_metadata(map = "org", metadata)
p$organisms



p$summary_stats

###Display functional information associated with core genes
p$core_clusters


###Calculate # of strains for each host type
table(p$organisms$Host)






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

plot_grid(Curves, Barplot,labels = "AUTO", ncol = 1) #SupportingFigure-Klebsiella-Pangenome-Curves-WGS_Analysis



###Curve together
Curves2 <- p$gg_curves() + 
  scale_color_manual(values = c("black", "black")) +  # Specify custom colors
  geom_point(alpha = .05, size = 4, color = '#82B446') +  # Set the size of the points
  theme_bw(base_size = 15) + 
  theme_minimal_hgrid(12) +
  theme(legend.position = "none") 
Curves2






###Generate a pie chart of core and shell genes 
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

custom_colors <- c("Fly" = "#cd3600", 
                   "Mastitis" = "#e1e386", 
                   "Cattle" = "#b7dbeb", 
                   "Manure" = "#648fff", 
                   "FlyNCBI" = "#f5abab",
                   "Human" = "#666363",
                   "WVDL" = "#d3e60b",
                   "Other" = "#c3c7c3" )

components <- pca_data[, c("PC1", "PC2")]

#SupportingFigure-Klebsiella-Kmeans-Curves-WGS_Analysis
wss<- fviz_nbclust(components, kmeans, method = "wss") # Leveling off at 4 or 5 clusters #Leveling off at 4
nbclust <- fviz_nbclust(components, kmeans, method = "silhouette") #peak at 3 cluster
plot_grid(wss, nbclust,labels = "AUTO", ncol = 2) 


ggplot(pca_data, aes(x = PC1, y = PC2, color = Host, fill = Host)) +
  geom_point(size = 3, shape = 21, color = "black", stroke = 1) +  # Points with black borders
  scale_color_manual(values = custom_colors) +  
  scale_fill_manual(values = custom_colors) +  
  theme_bw(base_size = 15) +
  labs(
       x = paste("PC1 (", round(pca$sdev[1]^2 / sum(pca$sdev^2) * 100, 2), "%)", sep = ""),
       y = paste("PC2 (", round(pca$sdev[2]^2 / sum(pca$sdev^2) * 100, 2), "%)", sep = "")) 



pca1 <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Host, fill = Host)) +
  geom_point(size = 3, shape = 21, color = "black", stroke = 0.5) +  # Points with black borders
  scale_color_manual(values = custom_colors) +  
  scale_fill_manual(values = custom_colors) +  
  theme_bw(base_size = 15) +
  labs(
    x = paste("PC1 (", round(pca$sdev[1]^2 / sum(pca$sdev^2) * 100, 2), "%)", sep = ""),
    y = paste("PC2 (", round(pca$sdev[2]^2 / sum(pca$sdev^2) * 100, 2), "%)", sep = ""))+
  theme(legend.title = element_blank()) +
  theme_cowplot(12) + theme(legend.position="none") 

pca1

#FigureS2-Fig5-Klebsiella-Global-Pangenome-WGS_Analysis
plot_grid(Curves2, pca1,labels = "AUTO", ncol = 1, rel_heights = c(1,2)) 



