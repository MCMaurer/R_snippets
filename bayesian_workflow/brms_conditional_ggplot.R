# packages ----------------------------------------------------------------
library(tidyverse)
library(brms)

# description -------------------------------------------------------------
# here's how to get the ggplot object from conditional_effects()

# example -----------------------------------------------------------------

m1 <- brm(mpg ~ wt + cyl, data = mtcars)

ce_wt <- conditional_effects(m1) %>% 
  plot(plot = F) %>% 
  pluck(1)

ce_cyl <- conditional_effects(m1) %>% 
  plot(plot = F) %>% 
  pluck(2)

ce_wt + scale_y_log10() 

ce_cyl + theme_bw()
