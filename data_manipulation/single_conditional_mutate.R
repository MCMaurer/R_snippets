# packages ----------------------------------------------------------------

library(tidyverse)

# description -------------------------------------------------------------
# I often use case_when() here, but with only two values this is much easier. Just use case_when() for 3+ options


# example -----------------------------------------------------------------

d <- data.frame(value = rnorm(100), is_here = c(T,F,F,F)) %>% as_tibble()
d %>% 
  mutate(value_here = ifelse(is_here, value, NA))
