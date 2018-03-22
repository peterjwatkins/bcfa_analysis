##
get_upper_tri <- function(cormat){
  cormat[lower.tri(cormat)]<- NA
  return(cormat)
}

library(tidyverse)
library(reshape2)

library(ggplot2) 
bcfa <- read_csv("data/bcfa_C17_fa.csv") 
#---------------------------------------

# Get lower triangle of the correlation matrix
get_lower_tri<-function(cormat){
  cormat[upper.tri(cormat)] <- NA
  return(cormat)
}
# Get upper triangle of the correlation matrix
get_upper_tri <- function(cormat){
  cormat[lower.tri(cormat)]<- NA
  return(cormat)
}

reorder_cormat <- function(cormat){
  # Use correlation between variables as distance
  dd <- as.dist((1-cormat)/2)
  hc <- hclust(dd)
  cormat <-cormat[hc$order, hc$order]
}
#-----------------------------------------
bcfa_cor <- bcfa %>%
  mutate(temp_id = 1:n()) %>% 
  gather(key = FA, val = content, -Year, -temp_id)  %>% 
  mutate(content = log10(content)) %>% 
  spread(FA, content) %>% 
  select(-temp_id) %>%
  split(.$Year) %>% 
  map(select, -Year) %>% 
  map(cor) 

cormat <- round(bcfa_cor$`2014`,3)

melted_cormat <- melt(cormat)

#ggplot(data = melted_cormat, aes(x=Var1, y=Var2, fill=value)) + 
#  geom_tile()


melted_cormat <- melt(upper_tri, na.rm = TRUE)
# Heatmap

#ggplot(data = melted_cormat, aes(Var2, Var1, fill = value))+
#  geom_tile(color = "white") +
#  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
#                       midpoint = 0, limit = c(-1,1), space = "Lab", 
#                       name="Pearson\nCorrelation") +
#  theme_minimal() + 
#  theme(axis.text.x = element_text(angle = 45, vjust = 1, 
#                                   size = 12, hjust = 1)) +
#  coord_fixed()

# Reorder the correlation matrix
cormat <- reorder_cormat(cormat)
upper_tri <- get_upper_tri(cormat)
# Melt the correlation matrix
melted_cormat <- melt(upper_tri, na.rm = TRUE)
# Create a ggheatmap
ggheatmap <- ggplot(melted_cormat, aes(Var2, Var1, fill = value))+
  geom_tile(color = "white") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0.0, limit = c(0,1), space = "Lab", 
                       name="Pearson\nCorrelation") +
  theme_minimal()+ # minimal theme
  theme(axis.text.x = element_text(angle = 45, vjust = 1, 
                                   size = 12, hjust = 1))+
  coord_fixed()
# Print the heatmap
# print(ggheatmap)
## -http://www.sthda.com/english/wiki/ggplot2-quick-correlation-matrix-heatmap-r-software-and-data-visualization
ggheatmap + 
  geom_text(aes(Var2, Var1, label = value), color = "black", size = 4) +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.grid.major = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank(),
    axis.ticks = element_blank(),
    legend.justification = c(1, 0),
    legend.position = c(0.4, 0.65),
    legend.direction = "horizontal") +
  guides(fill = guide_colorbar(barwidth = 7, barheight = 1,
                               title.position = "top", title.hjust = 0.5))


