# packages ----------------------------------------------------------------
library(tidyverse)
library(ggh4x)

# description -------------------------------------------------------------
# you can make a nice pointpath like base R instead of points + lines

# example -----------------------------------------------------------------

tibble(x = 1:50, y = exp(x/5)) %>% 
  ggplot(aes(x, y)) +
  geom_pointpath()


# compare to:

tibble(x = 1:50, y = exp(x/5)) %>% 
  ggplot(aes(x, y)) +
  geom_point() +
  geom_line()


tibble(x = seq(from = 0, to = 8, by = 0.2), y = sin(x)) %>% 
  ggplot(aes(x = x, y = y)) +
  geom_pointpath()


