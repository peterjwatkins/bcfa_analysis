## Trial plots
## Need to run 'data_wrangling.R' to form related objects
library(ggplot2) # assumes that 'tidyverse' library is present

# Will initially trial the use of scatterplots, as accustomed to doing this
# as first practice using 'messy' data


# http://www.cookbook-r.com/Graphs/Scatterplots_(ggplot2)/
ggplot(bcfa, aes(x = MOA, y= EOA)) +
  geom_point()  +
  facet_wrap(~Year)

ggplot(bcfa, aes(x = MOA, y= C17.0)) +
  geom_point()  +
  facet_wrap(~Year)

ggplot(bcfa, aes(x = MOA, y= C17.0)) +
  geom_point()  +
  scale_x_log10() +
  scale_y_log10() +
  facet_wrap(~Year)

ggplot(bcfa, aes(x = MOA, y= MNA)) +
  geom_point()  +
  scale_x_log10() +
  scale_y_log10() +
  facet_wrap(~Year)

ggplot(bcfa, aes(x = MOA, y= MNA, color=as.factor(Year))) +
  geom_point()  +
  scale_x_log10() +
  scale_y_log10()

## How does C17:0 relate to each BCFA?

p1 <- ggplot(bcfa, aes(x = MOA, y= C17.0, color=as.factor(Year))) +
  geom_point()  +
  scale_x_log10() +
  scale_y_log10() +
  labs(color = "Year")

p2 <- ggplot(bcfa, aes(x = EOA, y= C17.0, color=as.factor(Year))) +
  geom_point()  +
  scale_x_log10() +
  scale_y_log10() +
  labs(color = "Year")

p3 <- ggplot(bcfa, aes(x = MNA, y= C17.0, color=as.factor(Year))) +
  geom_point()  +
  scale_x_log10() +
  scale_y_log10() +
  labs(color = "Year")

## Need the use of a function called 'multipoint"
# http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/
source("scripts/multiplot.R")

multiplot(p1,p2,p3,cols=3)


#--------------------------------------------------------------------------------
# March 22, 2018

# Try different approach - make no assumptions

# Will use tidy approach
# this assumes that 'data_wrangling.R' has been run
# 'tidyverse' has been loaded and 'bcfa_tidy' is available

ggplot(bcfa_tidy, aes(x=FA, y=content)) +
  geom_point() +
  scale_y_log10() +
  facet_wrap(~Year)
  
ggplot(bcfa_tidy, aes(x=FA, y=content)) +
  geom_boxplot() +
  scale_y_log10() +
  facet_wrap(~Year)


## Out of interest, will plot the density plots for data
ggplot(bcfa_tidy, aes(x=FA, y=content)) +
  geom_density() +
  facet_wrap(~Year)
#.... and this code doesn't work :-)

bcfa_tidy %>% 
  select(-temp_id, -Year) %>% 
  ggplot(aes(x=FA)) + 
  geom_density() 
## this does, to a point but I'll stop here, and try later
## need to learn more on the commands

## Now, to do scatterplots...

## In this case, easier to spread the data, to it's original form...
## Now, assumes that bcfa_spread is present but could also use original 'bcfa' data
## assuming that it's a tibble

bcfa_spread %>% 
  ggplot(aes(x=MOA, y=MNA)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10() +  
  facet_wrap(~Year)

bcfa_spread %>% 
  ggplot(aes(x=MOA, y=`C17.0`)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10() +  
  facet_wrap(~Year)

bcfa_spread %>%
  ggplot(aes(x=EOA, y=`C17.0`)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10() +  
  facet_wrap(~Year)

bcfa_spread %>%
  ggplot(aes(x=MNA, y=`C17.0`)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10() +  
  facet_wrap(~Year)

## Changed 'Year' into factor
## new data: bcfa_yr_factor
bcfa_yr_factor %>%
  ggplot(aes(x=MOA, y=MNA)) + #, shape="Year")) + #, color="Year") +
  geom_point() +
  scale_x_log10() +
  scale_y_log10() 
## This is not plotting any data!!!!!!


bcfa_tidy %>% 
  spread(FA, content) %>% 
  select(-temp_id) %>% 
#  mutate(Year = as.factor(Year)) %>% 
  ggplot(aes(x=MOA, y=MNA)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10() +  
  facet_wrap(~Year)