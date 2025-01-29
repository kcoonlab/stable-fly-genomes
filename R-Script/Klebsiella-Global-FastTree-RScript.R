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

setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-5/Supporting-Files/Metadata")
df <- read_excel("Klebsiella-Global-Metadata.xlsx")

setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-5/Supporting-Files/FastTree-R")
tree <- ape::read.tree("Klebsiella-Global-FastTree.newick")
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
                               "Mastitis" = "#e1e386", 
                               "Cattle" = "#b7dbeb", 
                               "Manure" = "#648fff", 
                               "FlyNCBI" = "#f5abab",
                               "Human" = "#666363",
                               "WVDL" = "#d3e60b",
                               "Other" = "#c3c7c3" )) + 
  theme(legend.position="none") + 
  geom_tiplab(size =3) 



p1





p1<- ggtree(tree, branch.length='none', layout='circular') %<+% df +  
  geom_tippoint(aes(fill = Origin), size = 2, shape=22) +
  scale_fill_manual(values = c("Fly" = "#cd3600", 
                               "Mastitis" = "#e1e386", 
                               "Cattle" = "#b7dbeb", 
                               "Manure" = "#648fff", 
                               "FlyNCBI" = "#f5abab",
                               "Human" = "#666363",
                               "WVDL" = "#d3e60b",
                               "Other" = "#c3c7c3" )) + 
  theme(legend.position="none") + 
  geom_tiplab(size =3) 



p1






 

