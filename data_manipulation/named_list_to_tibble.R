# packages ----------------------------------------------------------------

library(tidyverse)

# description -------------------------------------------------------------
# going from a named list to a tibble with the names in a column and the values in another. I always forget how to do this.

# example -----------------------------------------------------------------

d <- list(GENE1 = c("one", "two", "three"),
     GENE2 = c("one", "three", "five", "seven"))

d <- enframe(d) %>% 
  unnest(value) 

d

