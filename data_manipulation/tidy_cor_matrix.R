# packages ----------------------------------------------------------------
library(tidyverse)

# description -------------------------------------------------------------

# Take a correlation matrix, pivot it to be long format, find correlations greater than some threshold, and then get rid of the duplicates (since the cor matrix is symmetrical)

# example -----------------------------------------------------------------
pearson <- cor(mtcars, method = "pearson")

pd <- as.data.frame(pearson)

pd %>% 
  rownames_to_column() %>% 
  pivot_longer(cols = -rowname) %>% 
  filter(abs(value) > 0.75) %>% 
  filter(rowname != name) %>%
  rowwise() %>% 
  mutate(myPairs = paste(sort(c(rowname, name), decreasing = TRUE), collapse = ", ")) %>% 
  distinct(myPairs, .keep_all = T)
