# packages ----------------------------------------------------------------

library(tidyverse)

# description -------------------------------------------------------------
# sometimes you might have a dataframe with all the characters as columns, but you want to do what readr would do, and guess the types, converting the numeric ones to numeric and leaving the characters as characters. you can do that!

# example -----------------------------------------------------------------

d <- mtcars %>% 
  as_tibble() %>% 
  mutate(across(everything(), as.character))

d %>% 
  type_convert()
