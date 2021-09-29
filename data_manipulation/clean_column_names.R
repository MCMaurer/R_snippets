# packages ----------------------------------------------------------------
library(readr)
library(janitor)

# description -------------------------------------------------------------
# cleaning up column names

# example -----------------------------------------------------------------

d <- read_csv("example_data/bad_names_example.csv")

d

d %>% 
  clean_names()

# can also specify here. note that the blank name doesn't go to ...2 and then to x2, it just goes to x
read_csv("example_data/bad_names_example.csv", name_repair = make_clean_names)
