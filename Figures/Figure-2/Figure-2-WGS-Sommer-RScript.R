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
library(phangorn)
library(MetBrewer)


setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-2/R-Import")


df <- read_excel("Escherichia-Metadata-FastTree.xlsx") #also called EscherichiaTree_WGSAnalysis.xlsx
names(df)[names(df) == "Strain"] <- "label"

tree <- ape::read.tree("Escherichia-FastTree.newick")
tree <- midpoint((tree)) #reroot the tree as using midpoint


p<- ggtree(tree) +  
  geom_tiplab()

p 

tip_order_plot <- p$data %>%
  filter(isTip) %>%
  arrange(y) %>%
  pull(label)

tip_order_plot
df$label <- factor(df$label, levels = tip_order_plot)
levels(df$label)

#Use this tree to determine the nodes associated with each phylogroup
ggtree(tree) %<+% df + geom_text(aes(label=node), hjust=2) +  
  geom_tippoint(aes(color = Mash_Phylogroup), size = 2) +
  geom_tiplab(align = TRUE, linesize = .5)


p1<- ggtree(tree) %<+% df +  
  geom_tippoint(aes(fill = Origin), size = 3, shape=22) +
  geom_tiplab(align = TRUE, linesize = .5, hjust = -1)  + #vjust to remove labels while keeping lines
  scale_fill_manual(values = c("Fly" = "#cd3600", "Manure" = "#648fff", "WVDL" = "#ddcc77")) +  theme(legend.position="none")  + xlim(0, 0.035) +
  geom_strip(52, 55, barsize=3, align =TRUE, color='#332288', 
             label="  D",extend = 0.5)  +
  geom_strip(51, 51, barsize=3, align =TRUE, color='#44aa99', 
             label="  B2", extend =0.5)  +
  geom_strip(61, 58, barsize=3, align =TRUE, color='orange', 
             label="  E", extend =0.5)      +
  geom_strip(47, 42, barsize=3, align =TRUE, color='#cc6677', 
             label="  A", extend =0.5)     +
  geom_strip(41, 15, barsize=3, align =TRUE, color='#117733', 
             label="  B1", extend =0.5)   

p1 

tip_nodes <- data.frame(node = tree$tip.label)
print(tip_nodes)


df_long <- pivot_longer(df, 
                        cols = c(Adhesion, EDS, Invasion, `Iron Uptake`, Other, Toxin),
                        names_to = "Category",
                        values_to = "Value")

df_long$label <- factor(df_long$label, levels = tip_order_plot)

category_order <- c("Adhesion", "EDS", "Invasion", "Iron Uptake", "Toxin", "Other")
df_long$Category <- factor(df_long$Category, levels = category_order)
df_long
p2<- ggplot(df_long, aes(x = label, y = Value, fill = Category)) +
  geom_bar(stat = "identity", position = "stack") +
  coord_flip()  +
  scale_fill_manual(values=met.brewer("Hokusai2", 6))+ 
  theme_minimal_vgrid() +  
  #theme(axis.text.y = element_blank()) +
  theme(axis.text.y = element_blank()) +
  theme(axis.title.x = element_blank()) +
  theme(axis.title.y = element_blank()) +  theme(legend.position="none")  


p2



df_long_2 <- pivot_longer(df, 
                          cols = c(APH,blaCMY,blaCTX,blaTEM,dfrA14,floR,fosA7,qnrS1,sul2,tet),
                          names_to = "ARG",
                          values_to = "Present")


p_ARG_heatmap <- ggplot(df_long_2, aes(x = ARG, y = label, fill = Present)) +
  geom_tile(color = "black", size = 0.05) +
  coord_fixed() +
  scale_fill_gradient(low = "whitesmoke", high = "slategray2") +
  theme_minimal()  +  theme(legend.position="none")  +  
  #  theme(axis.text.y = element_blank()) +
  theme(axis.title.x = element_blank()) +
  theme(axis.title.y = element_blank())+
  theme(axis.text.x = element_text(angle = 90, 
                                   size = 10, 
                                   hjust = 1, vjust =0.6)) +
  theme(plot.margin = margin(t = 0, r = 0, b = 0, l = 0, unit = "cm"))

p_ARG_heatmap



df_long_3 <- pivot_longer(df, 
                          cols = c(F17,afa,EAST1,eae,LT,LEE_esp,fae,hlyA,pap),
                          names_to = "VF",
                          values_to = "Present")

p_VF_heatmap <- ggplot(df_long_3, aes(x = VF, y = label, fill = Present)) +
  geom_tile(color = "black", size = 0.05) +
  coord_fixed() +
  scale_fill_gradient(low = "whitesmoke", high = "slategray2") +
  theme_minimal()  +  theme(legend.position="none")  +  
  theme(axis.text.y = element_blank()) +
  theme(axis.title.x = element_blank()) +
  theme(axis.title.y = element_blank())+
  theme(axis.text.x = element_text(angle = 90, 
                                   size = 10, 
                                   hjust = 1, vjust =0.6)) +
  theme(plot.margin = margin(t = 0, r = 0, b = 0, l = 0, unit = "cm"))

p_VF_heatmap

heatmaps <- p_ARG_heatmap %>% insert_right(p_VF_heatmap)



library(aplot)
heatmaps  %>% insert_left(p1) %>% insert_right(p2)

