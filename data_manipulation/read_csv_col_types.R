# packages ----------------------------------------------------------------
library(tidyverse)

# description -------------------------------------------------------------
# specify default column types and single column types in read_csv

# example -----------------------------------------------------------------

directory <- tempdir()
write_csv(mtcars, file = paste0(directory, "/mtcars.csv"))

# specify a single column and guess the rest
read_csv(paste0(directory, "/mtcars.csv"), 
         col_types = cols(vs = "l"))

# specify a single column and set a default
read_csv(paste0(directory, "/mtcars.csv"), 
         col_types = cols(vs = "l", .default = "d"))


