# packages ----------------------------------------------------------------
library(fs)
library(tidyverse)

# description -------------------------------------------------------------
# the end of this pipeline shows how to clean up the file name, removing the file extension and the directory path

# example -----------------------------------------------------------------

dir <- "example_data/storms_by_year/"

dir_ls(dir)

# using map_dfr
dir %>% 
  dir_ls(glob = "*.csv") %>% 
  set_names(.) %>% 
  map_dfr(read_csv, .id = "filename") %>% 
  mutate(year = path_file(filename) %>% 
           path_ext_remove() %>% 
           str_remove("storms_") %>% 
           as.double())

