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



setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Other/Staphylococcus-NCBI-Tree/FastTree-Metadata")
df <- read_excel("arlettae-Metadata-FastTree.xlsx")

setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Other/Staphylococcus-NCBI-Tree/FastTree")
tree <- ape::read.tree("arlettae-coregenome-FastTree.newick")
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




p1<- ggtree(tree) %<+% df +  
  geom_tippoint(aes(fill = Origin), size = 4, shape=22) +
  scale_fill_manual(values = c("Fly" = "#cd3600", 
                               "Manure" = "#648fff", 
                               "Cattle" = "#b7dbeb", 
                               "Mastitis" = "#e1e386", 
                               "Other" = "#c3c7c3" )) + 
  theme(legend.position="none") 


p1

ggtree(tree) %<+% df +  
  geom_tippoint(aes(fill = Origin), size = 4, shape=22) +
  geom_tiplab(size=3, hjust =-0.2) +
  scale_fill_manual(values = c("Fly" = "#cd3600", 
                               "Manure" = "#648fff", 
                               "Cattle" = "#b7dbeb", 
                               "Mastitis" = "#e1e386", 
                               "Other" = "#c3c7c3" )) + 
  theme(legend.position="none")  +
  expand_limits(x = max(tree$edge.length) + 0.01)
  







