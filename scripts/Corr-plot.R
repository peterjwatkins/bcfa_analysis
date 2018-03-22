#source(file = "scripts/data_wrangling.R")
library(tidyverse) ; library(ggpubr)
#----
get_upper_tri <- function(cormat){
  cormat[lower.tri(cormat)]<- NA
  return(cormat)
}
## 
##One thing that I would like to trial is a correlation plot...
## Using 'bcfa', spoke with Alex Whan, who offered this piece of script
## (this was before the submission of the dataset to AFDS)

bcfa %>% 
  mutate_at(vars(-Year), log10) %>% 
  group_by(Year) %>% 
  do(cor = cor(.[,1:4])) %>% 
  broom::tidy(cor) %>% 
  gather(.colnames, cor, -Year, -.rownames) %>% 
  ggplot(aes(.rownames, .colnames)) +
  geom_tile(aes(fill = cor)) +
  facet_wrap(~Year)

#----- found function 'ggscatter' to do scatterplot
# from 'ggpubr'
## ref: https://rstudio-pubs-static.s3.amazonaws.com/240657_5157ff98e8204c358b2118fa69162e18.html
## 20180322

bcfa %>% 
  ggscatter(x="MOA", y="MNA") +
  scale_x_log10() +
  scale_y_log10()


#-----------------------------------
## http://www.sthda.com/english/wiki/ggcorrplot-visualization-of-a-correlation-matrix-using-ggplot2
#if(!require(devtools)) install.packages("devtools")
#devtools::install_github("kassambara/ggcorrplot")
library(ggcorrplot)
bcfa.cor <- bcfa %>% 
  mutate_at(vars(-Year), log10) %>% 
  group_by(Year) %>% 
  do(cor = cor(.[,1:4])) %>% 
  broom::tidy(cor) %>% 
  gather(.colnames, cor, -Year, -.rownames)

bcfa_cor <- 
  bcfa %>% 
  mutate_at(vars(-Year), log10) %>% 
  filter(Year == 2011) %>% 
  select(-Year) %>% 
  do(cor = cor(.[,1:4])) %>% 
  broom::tidy(cor) %>%
  tibble::column_to_rownames()
