# packages ----------------------------------------------------------------

library(tidyverse)

# description -------------------------------------------------------------
# sometimes you want to sample entire groups, not sample WITHIN groups

# example -----------------------------------------------------------------

storms %>% 
  group_by(status, year) %>% 
  nest() %>% 
  ungroup() %>% 
  slice_sample(prop = 0.2) %>% 
  unnest(cols = data)

# this is how to sample a proportion within each group

storms %>% 
  group_by(status, year) %>% 
  slice_sample(prop = 0.2)
