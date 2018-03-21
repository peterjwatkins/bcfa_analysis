##
library(tidyverse)
#bcfa <- read_csv("data/20170912.csv") <- data from U:/2017/Lamb
bcfa <- read_csv("data/bcfa_C17_fa.csv") 

bcfa_tidy <-
  bcfa %>%
  gather(key = FA, val = content, -Year)  %>% 
  mutate(content = log10(content)) 

## https://community.rstudio.com/t/grouped-correlation-for-more-than-two-variables/3804/6
bcfa_corr <-
  bcfa %>%
  split(.$Year) %>% 
  map(select, -Year) %>% 
  map(cor)


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


## Contacted Alex Whan, who made these suggestions to try as 'corr plots'
#-------------------------------------------
bcfa %>% 
  mutate(temp_id = 1:n()) %>% 
  gather(FA, content, -Year, -temp_id) %>% 
  mutate(content = log10(content)) %>% 
  spread(FA, content) %>% 
  select(-temp_id) %>% 
  group_by(Year) %>% 
  do(cor = cor(.[,2:5])) %>% 
  broom::tidy(cor) %>% 
  gather(.colnames, cor, -Year, -.rownames) %>% 
  ggplot(aes(.rownames, .colnames)) +
  geom_tile(aes(fill = cor)) +
  facet_wrap(~Year)

#---------------------------------------------
bcfa %>% 
  mutate_at(vars(-Year), log10) %>% 
  group_by(Year) %>% 
  do(cor = cor(.[,1:4])) %>% 
  broom::tidy(cor) %>% 
  gather(.colnames, cor, -Year, -.rownames) %>% 
  ggplot(aes(.rownames, .colnames)) +
  geom_tile(aes(fill = cor)) +
  facet_wrap(~Year)