library(dplyr)
library(tidyr)
library(ggplot2)
library(tidyverse)
library(readxl)
library(xlsx)
library(reshape2)  
library(cowplot)
setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-6/R-Import")

EC_Residuals <-read_excel("sciuri-topresiduals-EC-emapper.xlsx", col_names = TRUE)



head(EC_Residuals)

data_long <- melt(EC_Residuals,
                  variable.name="Cluster",
                  value.name="ChiRes")

data_long <- data_long %>% relocate(Name , .after = last_col()) 


unique(data_long$Cluster)

custom_colors <- c("Cluster_1" = "#d1bc9d",                              
                   "Cluster_2" = "#b7c78d", 
                   "Cluster_3" = "#8bb091", 
                   "Cluster_4" = "#945364", 
                   "Cluster_5" = "#cae3e0")


unique(data_long$EC)

order <- c("4.2.1.48", "2.8.2.23","2.8.2.30",
           "2.1.3.2", "3.2.1.52","3.2.2.20", 
           "3.4.11.5", "3.2.1.141", "5.3.1.5", "2.7.1.17")


data_long$EC <- factor(data_long$EC, levels = rev(order))





#3.5x3

ResidualsPlot <- ggplot(data_long, aes(x = EC, y = ChiRes)) + 
  geom_point(aes(colour=Cluster), size = 4) + 
  geom_point(shape = 1,colour = "black", size = 4, stroke = 0.25)  + coord_flip()   +
  theme_half_open()  +   
  scale_color_manual(values = custom_colors)  +
  theme_cowplot(12) + 
  theme(panel.grid.major.y = element_line(color = "black", linewidth = 0.5, linetype = 2)) +
  theme(legend.position = "none")  + geom_hline(yintercept = 0, linetype=2,color = "black", size=0.5) +
  xlab(" ") + ylab("Standardized Residuals") +
  theme(axis.text = element_text(size = 11))

ResidualsPlot
save(ResidualsPlot, file = "sciuri-Residuals-Plot.RData")

