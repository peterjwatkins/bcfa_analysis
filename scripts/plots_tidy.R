## Trial plots
## Need to run 'data_wrangling.R' to form related objects
library(ggplot2) # assumes that 'tidyverse' library is present

## object as 'tidy'

MOA <- bcfa_m %>%
  filter(FA == "MOA")

ggplot(MOA, aes(x = as.factor(Year), y = content)) +
  geom_point()

bcfa_m  %>%  
ggplot(filter(bcfa_m, FA == "MNA"), aes(x = as.factor(Year), y = content)) +
  geom_point()

ggplot(bcfa_spread, aes(x=`MOA`, y=`C17.0`, color=as.factor('Year'))) +
  geom_point() +
  scale_x_log10()
