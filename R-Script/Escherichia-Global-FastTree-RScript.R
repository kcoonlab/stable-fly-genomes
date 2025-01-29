library(ggplot2)
library(ggtree)
library(treeio)
library(ggnewscale)
library(readxl)
library(cowplot)
library(gridExtra)
library(ape)
library(aplot)
library(dplyr)
library(tidyr)
library(MetBrewer)
library(phangorn)


setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-3/Supporting-Files/Metadata")
df <- read_excel("Escherichia-Global-Metadata.xlsx")


setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-3/Supporting-Files/FastTree-R")
tree <- ape::read.tree("Escherichia-Global-FastTree.newick")
tree <- midpoint((tree)) #reroot the tree as using midpoint





p<- ggtree(tree) +  
  geom_tiplab(size =2) 
p






names(df)[names(df) == "Strain"] <- "label"
tip_order_plot <- p$data %>%
  filter(isTip) %>%
  arrange(y) %>%
  pull(label)

df$label <- factor(df$label, levels = tip_order_plot)
levels(df$label)

unique(df$Origin)

custom_colors <- c("Fly" = "#cd3600", "Manure" = "#648fff","WVDL" = "#d3e60b",
                   "Mastitis" = "#e1e386",
                   "Cattle" = "#b7dbeb",
                   "FlyNCBI" = "#f5abab",
                   "Pathogen" = "#666363",
                   "ECOR" = "#c3c7c3" )




p1<- ggtree(tree) %<+% df +  
  geom_tippoint(aes(fill = Origin), size = 4, shape=22) +
  scale_fill_manual(values = custom_colors) +
  theme(legend.position="none") + 
  geom_tiplab(size =3) 


p1 #save as 50x50 inch plot



p1<- ggtree(tree, branch.length='none', layout='circular') %<+% df +  
  geom_tippoint(aes(fill = Origin), size = 2, shape=22) +
  scale_fill_manual(values = custom_colors) +
  theme(legend.position="none") 


p1







