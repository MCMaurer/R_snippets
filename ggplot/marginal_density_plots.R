# packages ----------------------------------------------------------------
library(tidyverse)
library(ggside)

# description -------------------------------------------------------------
# easy way to get marginal side plots

# example -----------------------------------------------------------------

mtcars %>% 
  mutate(cyl = factor(cyl)) %>% 
  ggplot(aes(x = wt, y = mpg, color = cyl)) +
  geom_point() +
  geom_ysidedensity() +
  geom_xsidedensity() +
  scale_xsidey_continuous(breaks = c(0.25,0.75)) +
  scale_ysidex_continuous(breaks = c(0.1,0.2)) +
  theme(ggside.panel.scale = .3)