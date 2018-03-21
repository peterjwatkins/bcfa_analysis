library(tidyverse)

bcfa <- read_csv("data/bcfa_C17_fa.csv") 
## Start fresh and assume no prior
#--- Create 'tidy' frame
bcfa_tidy <-
  bcfa %>% 
  mutate(temp_id = 1:n()) %>% 
  gather(key = FA, val = content , -Year, -temp_id)


#  Now, we spread data in FA
bcfa_spread <- bcfa_tidy %>% 
  spread(FA, content) %>% 
  select(-temp_id)