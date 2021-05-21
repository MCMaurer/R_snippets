# packages ----------------------------------------------------------------

library(tidyverse)
library(brms)
library(tidybayes)

# description -------------------------------------------------------------
# tidybayes actually makes it kinda tricky to just do a halfeye plot of all your fixed beta params, which is something you wanna do pretty often

# example -----------------------------------------------------------------

m1 <- brm(mpg ~ wt + (1|cyl), data = mtcars)

posterior_samples(m1) %>% 
  select(starts_with("b_")) %>% 
  pivot_longer(everything()) %>% 
  ggplot(aes(x = value, y = name)) +
  geom_vline(xintercept = 0, linetype = 2, color = "gray90") +
  stat_halfeye() +
  theme_bw()
