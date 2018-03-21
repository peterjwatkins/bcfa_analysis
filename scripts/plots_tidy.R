## Trial plots
## Need to run 'data_wrangling.R' to form related objects
library(ggplot2) # assumes that 'tidyverse' library is present

## object as 'tidy'

tmp <- bcfa_m %>%
  filter(FA == "MOA")

