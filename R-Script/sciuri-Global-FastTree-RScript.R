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


setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-6/R-Import")
df <- read_excel("sciuri-Global-Metadata.xlsx")

setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-6/Supporting-Files/FastTree-R")
tree <- ape::read.tree("sciuri-Global-FastTree.newick") #This is a core genome based tree
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


p1<- ggtree(tree) %<+% df +  
  geom_tippoint(aes(fill = Origin), size = 2, shape=22) +
  scale_fill_manual(values = c("Fly" = "#cd3600",                              
                               "Manure" = "#648fff", 
                               "Cattle" = "#b7dbeb", 
                               "Mastitis" = "#e1e386", 
                               "Other" = "#c3c7c3" )) + 
  theme(legend.position="none") + 
  geom_tiplab(size =3) 


p1




custom_colors <- c("Fly" = "#cd3600",                              
                   "Cattle_Manure" = "#648fff", 
                   "Cattle_NonManure" = "#d9abee", 
                   "Bovine_Mastitis" = "#e1e386", 
                   "Other_Animal" = "#c3c7c3",
                   "Other" = "#c3c7c3" )

library(ape)
subtree <- extract.clade(tree, node=421)
subtree_plot <- ggtree(subtree)
subtree_plot %<+% df +  
  geom_tippoint(aes(fill = Origin), size = 2, shape=22) +
  scale_fill_manual(values = custom_colors) + 
  theme(legend.position="none") +  
  geom_tiplab(size =2) 








