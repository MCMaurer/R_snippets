# packages ----------------------------------------------------------------
library(corrr)
library(tidyverse)

# description -------------------------------------------------------------
# Using the corrr package to get quick correlation estimates and corr plots.

# example -----------------------------------------------------------------

mtcars %>% 
  correlate() %>% 
  autoplot() +
  geom_text(aes(label = round(r, digits = 2), color = r), size = 2.5) +
  scale_fill_viridis_c(option = "A") +
  scale_color_gradient2(low = "white", mid = "white", high = "black", guide = NULL)

# doing the above, but manually
mtcars %>% 
  correlate() %>% 
  rearrange(method = "PCA") %>% 
  shave() %>% 
  rplot()

# provides different ways to cluster columns together
seriation::list_seriation_methods()

mtcars %>% 
  correlate() %>% 
  rearrange(method = "HC") %>% 
  autoplot() +
  scale_fill_viridis_c(option = "A")


MCMsBasics::cars_mpg %>% 
  correlate() %>% 
  autoplot(method = "ARSA") +
  #geom_text(aes(label = round(r, digits = 2), color = r), size = 2.5) +
  scale_fill_viridis_c(option = "A") +
  scale_color_gradient2(low = "white", mid = "white", high = "black", guide = NULL)
