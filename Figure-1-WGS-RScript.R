library(readxl)
library(ggplot2)
library(cowplot)
library(patchwork)
library(dplyr)



setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-1/R-Import")


df1 <-read_excel("GenomeQuality_WGSAnalysis.xlsx", col_names = TRUE)






p_Contamination <- ggplot(df1, aes(x=Contamination))+
  geom_histogram(color="black", fill="lightblue", binwidth =.05) +
  theme_half_open() +
  #background_grid() +
  scale_y_continuous(breaks=c(10,20,30,40), expand = expansion(mult = c(0, 0.2)))+
  scale_x_continuous(breaks= seq(0, 5, by = 1), expand = expansion(mult = c(0, 0.05))) + 
  theme(panel.grid.major.y = element_line(color = "grey",
                                          size = 0.5,
                                          linetype = 2))+
  xlab("Contamination  (%)") + ylab(" ")+
  theme(axis.title.x = element_text(size = 14)) +
  theme(axis.title.y = element_text(size = 14))+
  theme(axis.text = element_text(size=12))
p_Contamination


p_N50 <- ggplot(df1, aes(x=N50))+
  geom_histogram(color="black", fill="lightblue", boundary = min(df1$N50), binwidth = 50000) +
  theme_half_open() +
  scale_y_continuous(breaks=c(10,20,30,40), expand = expansion(mult = c(0, 0.05)))+
  scale_x_continuous(breaks=seq(0, 3E6, by = 10E5), labels = scales::scientific, expand = c(0, 0.2))  + 
  theme(panel.grid.major.y = element_line(color = "grey",
                                          size = 0.5,
                                          linetype = 2))  +
  xlab("N50") + ylab("Number of Genomes")+
  theme(axis.title.x = element_text(size = 14)) +
  theme(axis.title.y = element_text(size = 14))+
  theme(axis.text = element_text(size=12))
p_N50

combined_plot_top <- p_N50 + p_Contamination + plot_layout(ncol = 2, heights = c(1, 1))
combined_plot_top





p_Completeness <- ggplot(df1, aes(x=Completeness))+
  geom_histogram(color="black", fill="lightblue", binwidth =.05) +
  theme_half_open() +
  #background_grid() +
  scale_y_continuous(breaks = c(50, 100, 150, 200), expand = expansion(mult = c(0, 0)), limits = c(0, 250)) + 
  scale_x_continuous(breaks= seq(95, 100, by = 1)) + 
  theme(panel.grid.major.y = element_line(color = "grey",
                                          linewidth  = 0.5,
                                          linetype = 2)) +
  xlab("Completeness (%)") + ylab(" ") +
  theme(axis.title.x = element_text(size = 14)) +
  theme(axis.title.y = element_text(size = 14))+
  theme(axis.text = element_text(size=12))
p_Completeness

p_BUSCO <- ggplot(df1, aes(x=BUSCO_S)) +
  geom_histogram(color="black", fill="lightblue", binwidth = 1) +
  theme_half_open() +
  scale_y_continuous(breaks = c(50, 100, 150,200), expand = expansion(mult = c(0, 0)), limits = c(0, 250)) +
  scale_x_continuous(expand = expansion(mult = c(0, 0.05))) + 
  theme(panel.grid.major.y = element_line(color = "grey", size = 0.5, linetype = 2)) +
  xlab("Number of Single Copy BUSCOs") + 
  ylab("Number of Genomes")
  theme(axis.title.x = element_text(size = 14)) +
  theme(axis.title.y = element_text(size = 14))+
  theme(axis.text = element_text(size=12))
p_BUSCO

combined_plot_bottom <- p_Completeness + p_BUSCO + plot_layout(ncol = 2, heights = c(1, 1))
combined_plot_bottom

final_combined_plot <- p_N50 + p_Contamination + p_BUSCO + p_Completeness  + plot_layout(ncol = 2, heights = c(1, 1))
final_combined_plot


###Boxplots Figure 1D


df2<-df1[!(df1$Genus=="Citrobacter" | df1$Genus=="Kosakonia" | df1$Genus=="Proteus"| df1$Genus=="Pseudescherichia"| df1$Genus=="Raoultella"| df1$Genus=="Salmonella"| df1$Genus=="Serratia"| df1$Genus=="Siccibacter"|df1$Genus=="Bacillus"),]


label_df2 <- df2 %>%
  group_by(Genus) %>%
  summarize(count = n())



p_violin_reduced <- ggplot(df2, aes(x=Genus, y=CDS, fill=Genus)) + 
  geom_violin(color = "black", fill = 'lightblue') +  
  geom_boxplot(width=0.1, color = "black", fill = 'grey') +
  theme_half_open() + 
  theme(panel.grid.major.y = element_line(color = "grey", size = 0.5, linetype = 2)) +
  theme(legend.position = "none") + coord_flip() +
  geom_text(data = label_df2, aes(label = paste("N=", count), x = Genus, y = 5500), 
            vjust = -0.5, size = 4, color = "black")






Rename <- c("Citrobacter", "Kosakonia", "Proteus", "Pseudescherichia", 
            "Raoultella", "Salmonella", "Serratia", "Siccibacter")
df3 <- df1 %>%
  mutate(Genus = ifelse(Genus %in% Rename, "Enterobacterales", Genus))

df3$Genus <- factor(df3$Genus)
df3$Genus <- factor(df3$Genus, levels = rev(levels(df3$Genus)))


label_df3 <- df3 %>%
  group_by(Genus) %>%
  summarize(count = n())

p_violin_all <- ggplot(df3, aes(x=Genus, y=CDS, fill=Genus)) + 
  geom_violin(color = "black", fill = 'lightblue') +  
  geom_boxplot(width=0.05, color = "black", fill = 'grey') +
  theme_half_open() + 
  theme(panel.grid.major.y = element_line(color = "grey", size = 0.5, linetype = 2)) +
  theme(legend.position = "none") + coord_flip() +
  geom_text(data = label_df3, aes(label = paste("N=", count), x = Genus, y = 5500), 
            vjust = -0.5, size = 3, color = "black") +
  theme(axis.title.y=element_blank())

p_violin_all

library(cowplot)

# Combine p_violin_all with final_combined_plot
full_plot <- plot_grid(final_combined_plot, p_violin_all, ncol = 2, rel_widths = c(1, 0.5))

# Display the combined plot
full_plot

