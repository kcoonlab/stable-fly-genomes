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

setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-4/R-Import")


df <- read_excel("Klebsiella-Metadata-FastTree.xlsx")
names(df)[names(df) == "Strain"] <- "label"

tree <- ape::read.tree("Klebsiella-FastTree.newick")
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

p1<- ggtree(tree) %<+% df +  
  geom_tippoint(aes(fill = Origin), size = 3, shape=22) +
  geom_tiplab(align = TRUE, linesize = .5, hjust = -0.5)  + #vjust to remove labels while keeping lines
  scale_fill_manual(values = c("Fly" = "#cd3600", "Manure" = "#648fff", "WVDL" = "#ddcc77")) + 
  theme(legend.position="none")  +  xlim(0, 0.015) 

p1






tip_nodes <- data.frame(node = tree$tip.label)
print(tip_nodes)

df_longARG <- pivot_longer(df, 
                        cols = c(aadA2,APH,blaCMY,blaCTX,catA2,dfrA12,lnuF,mphA,qnrS1,str,sul,tet),
                        names_to = "ARG",
                        values_to = "Present")

df_longARG$label <- factor(df_longARG$label, levels = tip_order_plot)


p_ARG_heatmap <- ggplot(df_longARG, aes(x = ARG, y = label, fill = Present)) +
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

library(aplot)
p_ARG_heatmap  %>% insert_left(p1) 



df_longVF <- pivot_longer(df, 
                          cols = c(astA,entA,entB,fepC,fepG,ompA,yagV,yagW,yagX,yagY,yagZ,ykgK),
                          names_to = "VF",
                          values_to = "Present")
df_longVF$label <- factor(df_longVF$label, levels = tip_order_plot)



p_VF_heatmap <- ggplot(df_longVF, aes(x = VF, y = label, fill = Present)) +
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
heatmaps  %>% insert_left(p1, width = 1)  #8x8 
