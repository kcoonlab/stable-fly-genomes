library(gggenomes)
library(readxl)
library(dplyr)

setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-7/Plasmid-Maps/input")
tetK_bakta <- read_excel("tetK-plasmid-reindexed.xlsx")

tetK_bakta

###Sequences
s0 <- tetK_bakta %>% select(seq_id,length)
s0 <- unique(s0)

###Genes
g0 <- tetK_bakta %>% select(seq_id,start,end,gene,strand,type)
g0 <- g0 %>%
  filter(type == "CDS")






p <- gggenomes(genes=g0, seqs=s0)

p + 
  geom_seq() +         # draw contig/chromosome lines
  geom_seq_label() +   # label each sequence 
  geom_gene() +
  geom_gene(aes(fill=gene))         # draw genes as arrow



#scale order: pre, rep, tetK


p + 
  geom_seq() +         # Draw contig/chromosome lines
  geom_seq_label(size = 5) +   # Label each sequence 
  geom_gene(aes(fill = gene), size = 5) + 
  scale_fill_manual(values = c("#C4B7CB", "#9bc1bc", "#ed6a5a"))
