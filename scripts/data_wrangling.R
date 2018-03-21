library(tidyverse)

bcfa <- read_csv("data/bcfa_C17_fa.csv") 
## Start fresh and assume no prior
#--- Create 'tidy' frame
bcfa_tidy <-
  bcfa %>%
  gather(key = FA, val = content, -Year) %>%
  mutate(temp_id = 1:n())                     # add seq of integers as unique ID

#  Now, we spread data in FA
bcfa_spread <- bcfa_tidy %>% 
  spread(FA, content)