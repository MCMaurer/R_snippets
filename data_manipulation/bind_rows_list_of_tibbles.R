# packages ----------------------------------------------------------------
library(dplyr)
library(purrr)

# description -------------------------------------------------------------

# quickly collapse a list of tibbles

# example -----------------------------------------------------------------

l <- map(1:10, ~slice_sample(mtcars, prop = 0.5))

bind_rows(l, .id = "iter")