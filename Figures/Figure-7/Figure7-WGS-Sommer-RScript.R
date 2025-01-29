###Figure ARG Analysis
library(readxl)
library(dplyr)
library(NatParksPalettes)
library(cowplot)
library(reshape2)
library(ggplot2)
library(circlize)  
library(ComplexHeatmap)
library(grid)  
library(forcats)

####Plots A and B
setwd("C:/Users/asomm/OneDrive - UW-Madison/Work_Documents/Projects/WGS_StableFly_Analysis/Manuscript/Figures/Figure-7/R-Import")
df <- read_excel("Staphylococcus-ARG-Location-Figure7A.xlsx")


count_result <- df %>%
  group_by(PRODUCT, PLASMID,GENUS) %>%
  summarise(count = n(), .groups = 'drop') 


count_result <- count_result %>%
  mutate(GENUS = if_else(GENUS == "Staphylococcus", "S", 
                         if_else(GENUS == "Mammaliicoccus", "M", GENUS)))

count_result <- count_result %>%
  mutate(GENUS = factor(GENUS, levels = c("M", "S"))) 



count_result$PRODUCT <- factor(count_result$PRODUCT, levels = rev(sort(unique(count_result$PRODUCT))))
PlotA <-
  ggplot(count_result, aes(x = PRODUCT, y = count, fill = PLASMID)) +
  geom_bar(stat = "identity", color = "black") +
#  geom_text(aes(label = GENUS, y = count), position = position_stack(vjust = 0.5), size = 3) +  
  labs(
    x = "Product",
    y = "Count") +
  theme_minimal() +
  scale_fill_manual(values = c("#4B6F44","#87A96B")) +
  coord_flip() +
  theme_cowplot(12) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 49))  +
  theme(axis.text.x = element_text(vjust = 1, size = 12)) +
  theme(axis.text.y = element_text(hjust = 1, size = 12)) +
  theme(legend.position="none")

PlotA #Note that this seperates the M and S with the lines

df2 <- read_excel("Staphylococcus-ARG-PlasmidTyping-Figure7B.xlsx")
df2

count_result2 <- df2 %>%
  group_by(REPLICON, PRODUCT) %>%
  summarise(count = n(), .groups = 'drop')

count_result2 <- count_result2 %>%
  group_by(REPLICON) %>%
  mutate(total_count = sum(count))

PlotB <- ggplot(count_result2, aes(x = fct_reorder(REPLICON, total_count), y = count)) +
  geom_bar(stat = "identity", fill = "#87A96B", color = "black", linewidth = 0.5) +  
  labs(x = " ",y = "Count") +
  theme_minimal() +
  coord_flip() +
  theme_cowplot(12) +
  geom_text(aes(label = PRODUCT, y = count), 
            position = position_stack(vjust = 0.5), size = 3)  +
  scale_y_continuous(expand = c(0, 0),breaks=c(2,4,6,8,10,12), limits = c(0, 12) ) +
  theme(axis.text.x = element_text(vjust = 1, size = 12)) +
  theme(axis.text.y = element_text(hjust = 1, size = 12))

PlotB

library(ggpubr)
plot_grid(PlotA, PlotB, labels = c('A', 'B'), label_size = 12, rel_widths = c(1, 2))



####lnuA heatmap
lnuA_ani <- read_excel("Staphylococcus-lnuA-mobmess-ani-Figure7C.xlsx")
lnuA_metadata <- read_excel("Staphylococcus-lnuA-metadata-Figure7C.xlsx")
lnuA_matrix <- acast(lnuA_ani, reference~query, value.var="I_global")

annotationC_lnuA <- data.frame(Source = lnuA_metadata$Source,Taxa = lnuA_metadata$Taxa)
rownames(annotationC_lnuA) <- lnuA_metadata$Strain  
annotationC_lnuA <- annotationC_lnuA[colnames(lnuA_matrix), , drop = FALSE]


torres_colors <- natparks.pals("Torres", 10)

annotation_colors_lnuA <- list(
  Source = c("Fly" = "#cd3600", 
             "Manure" = "#648fff", 
             "Reference" = "#c3c7c3", 
             "WVDL" = "#e1e386"),
  Taxa = c( 
    "S.arlettae" = torres_colors[1],
    "S.chromogenes" = torres_colors[2],
    "S.equorum" = torres_colors[3],
    "S.gallinarum" = torres_colors[4],
    "S.haemolyticus" = torres_colors[5],
    "S.saprophyticus" = torres_colors[7],
    "S.xylosus" = torres_colors[8],
    "M.sciuri" = torres_colors[10],
    "Reference" = "#c3c7c3"))


colors <- colorRamp2(c(0, 0.5, 1), c("lightskyblue", "white", "coral"))

wcss <- numeric()
for (i in 1:10) {
  kmeans_result <- kmeans(lnuA_matrix, centers = i)
  wcss[i] <- kmeans_result$tot.withinss
}
plot(1:10, wcss, type = "b", pch = 19, xlab = "Number of Clusters (k)", ylab = "WCSS")

#Without legend
top_annotation <- HeatmapAnnotation(df = annotationC_lnuA, 
                                    col = annotation_colors_lnuA,
                                    show_legend = FALSE,        
                                    simple_anno_size = unit(0.5, "cm"),
                                    gp = gpar(col = "black", lwd = 0.25))  
PlotC <- 
  Heatmap(lnuA_matrix,
          name = "Similarity",
          row_names_side = "right",
          column_names_side = "bottom",
          row_dend_side = "left",
          column_dend_side = "top",
          col = colors, 
          row_km = 3, row_km_repeats = 100,
          column_km = 3, column_km_repeats = 100,
          top_annotation = top_annotation,
          show_row_dend = FALSE,  
          show_heatmap_legend = FALSE,
          width = unit(5, "in"), height = unit(5, "in"),
          rect_gp = gpar(col = "black", lwd = 0.25))  

PlotC



#With legend
top_annotation <- HeatmapAnnotation(df = annotationC_lnuA, 
                                    col = annotation_colors_lnuA,
                                    simple_anno_size = unit(0.5, "cm"),
                                    gp = gpar(col = "black", lwd = 0.25))  
lnuA_heatmap <- 
  Heatmap(lnuA_matrix,
          name = "Similarity",
          row_names_side = "right",
          column_names_side = "bottom",
          row_dend_side = "left",
          column_dend_side = "top",
          col = colors, 
          row_km = 3, row_km_repeats = 100,
          column_km = 3, column_km_repeats = 100,
          top_annotation = top_annotation,
          show_row_dend = FALSE,  
          width = unit(5, "in"), height = unit(5, "in"),
          rect_gp = gpar(col = "black", lwd = 0.25))  
lnuA_heatmap









##### heatmap tetK

tetK_ani <- read_excel("Staphylococcus-tetK-mobmess-ani-Figure7-Supp.xlsx")
tetK_metadata <- read_excel("Staphylococcus-tetK-metadata-Figure7-Supp.xlsx")



tetK_matrix <- acast(tetK_ani, reference~query, value.var="I_global")


annotationC_tetK <- data.frame(
  Source = tetK_metadata$Source,
  Taxa = tetK_metadata$Taxa
)
rownames(annotationC_tetK) <- tetK_metadata$Strain  # Set 'Name' as row names

colnames(tetK_matrix)
rownames(annotationC_tetK)
annotationC_tetK <- annotationC_tetK[colnames(tetK_matrix), , drop = FALSE]


unique(tetK_metadata$Taxa)
unique(tetK_metadata$Source)

torres_colors <- natparks.pals("Torres", 10)

annotation_colors_tetK <- list(
  Source = c("Fly" = "#cd3600", 
             "Reference" = "#c3c7c3"),
  Taxa = c( 
    "S.arlettae" = torres_colors[1],
    "S.xylosus" = torres_colors[8],
    "S.shinii" = torres_colors[9],
    "Reference" = "#c3c7c3"))

colors <- colorRamp2(c(0, 0.5, 1), c("lightskyblue", "white", "coral"))

wcss <- numeric()
for (i in 1:10) {
  kmeans_result <- kmeans(tetK_matrix, centers = i)
  wcss[i] <- kmeans_result$tot.withinss
}
plot(1:10, wcss, type = "b", pch = 19, xlab = "Number of Clusters (k)", ylab = "WCSS")

#No legend
top_annotation <- HeatmapAnnotation(df = annotationC_tetK, 
                                    col = annotation_colors_tetK,
                                    show_legend = FALSE,        
                                    simple_anno_size = unit(0.5, "cm"),
                                    gp = gpar(col = "black", lwd = 0.25))  
PlotD <- Heatmap(tetK_matrix,
        name = "ANI",
        row_names_side = "right",
        column_names_side = "bottom",
        row_dend_side = "left",
        column_dend_side = "top",
        col = colors,  # Custom color palette
        row_km = 3, row_km_repeats = 100,
        column_km = 3, column_km_repeats = 100,
        top_annotation = top_annotation,
        show_row_dend = FALSE,  
        show_heatmap_legend = FALSE,
        heatmap_width = unit(5, "in"), heatmap_height = unit(5, "in"),
        rect_gp = gpar(col = "black", lwd = 0.25))  # Border around heatmap tiles

PlotD





#With legend
top_annotation <- HeatmapAnnotation(df = annotationC_tetK, 
                                    col = annotation_colors_tetK,
                                    simple_anno_size = unit(0.5, "cm"),
                                    gp = gpar(col = "black", lwd = 0.5))  # Border for each tile
Heatmap(tetK_matrix,
        name = "ANI",
        row_names_side = "right",
        column_names_side = "bottom",
        row_dend_side = "left",
        column_dend_side = "top",
        col = colors,  # Custom color palette
        row_km = 3, row_km_repeats = 100,
        column_km = 3, column_km_repeats = 100,
        top_annotation = top_annotation,
        show_row_dend = FALSE,  
        heatmap_width = unit(5, "in"), heatmap_height = unit(5, "in"),
        rect_gp = gpar(col = "black", lwd = 0.25))  # Border around heatmap tiles







###9x4




















####str supp heatmap

str_ani <- read_excel("Staphylococcus-str-mobmess-ani-Figure7-Supp.xlsx")
str_metadata <- read_excel("Staphylococcus-str-metadata-Figure7-Supp.xlsx")



str_matrix <- acast(str_ani, reference~query, value.var="I_global")


annotationR_str <- data.frame(
  Source = str_metadata$Source,
  Taxa = str_metadata$Taxa
)
rownames(annotationR_str) <- str_metadata$Strain  # Set 'Name' as row names


annotationC_str <- data.frame(
  Source = str_metadata$Source,
  Taxa = str_metadata$Taxa
)
rownames(annotationC_str) <- str_metadata$Strain  # Set 'Name' as row names

colnames(str_matrix)
rownames(annotationC_str)
annotationC_str <- annotationC_str[colnames(str_matrix), , drop = FALSE]


unique(str_metadata$Taxa)
unique(str_metadata$Source)


annotation_colors_str <- list(
  Source = c("Fly" = "#cd3600", 
             "Manure" = "#648fff", 
             "Reference" = "#c3c7c3"),
  Taxa = c( 
    "M.sciuri" = torres_colors[10],
    "S.chromogenes" = torres_colors[2],
    "S.shinii" = torres_colors[9],
    "Reference" = "#c3c7c3"))





top_annotation <- HeatmapAnnotation(df = annotationC_str, 
                                    col = annotation_colors_str,
                                    simple_anno_size = unit(0.5, "cm"),
                                    gp = gpar(col = "black", lwd = 0.5))  # Border for each tile

colors <- colorRamp2(c(0, 0.5, 1), c("lightskyblue", "white", "coral"))


#k-means cluster
wcss <- numeric()
for (i in 1:10) {
  kmeans_result <- kmeans(str_matrix, centers = i)
  wcss[i] <- kmeans_result$tot.withinss
}
plot(1:10, wcss, type = "b", pch = 19, xlab = "Number of Clusters (k)", ylab = "WCSS")


Heatmap(str_matrix,
        name = "ANI",
        row_names_side = "right",
        column_names_side = "bottom",
        row_dend_side = "left",
        column_dend_side = "top",
        show_row_dend = FALSE,
        col = colors,  # Custom color palette
        row_km = 3, row_km_repeats = 100,
        column_km = 3, column_km_repeats = 100,
        top_annotation = top_annotation,
        width = unit(5, "in"), height = unit(5, "in"),
        rect_gp = gpar(col = "black", lwd = 0.25))  # Border around heatmap tiles






