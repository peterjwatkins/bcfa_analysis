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
