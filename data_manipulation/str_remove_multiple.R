# packages ----------------------------------------------------------------
library(stringr)

# description -------------------------------------------------------------
# to remove multiple patterns, you can use the | to separate them. str_c collapses the arguments to a single string

# example -----------------------------------------------------------------

"thing_1.txt" %>% 
  str_remove_all(pattern = str_c("thing_", "\\.txt", sep = "|"))

