# packages ----------------------------------------------------------------
library(fs)
library(tidyverse)

# description -------------------------------------------------------------
# read a bunch of CSVs into dataframe using the name of the file as an identifier

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

# using dir_map
dir %>% 
  dir_map(fun = function(x) if (endsWith(x, ".csv")) read_csv(x)) %>% 
  set_names(dir_ls(dir, glob = "*.csv")) %>% 
  bind_rows(.id = "filename") %>% 
  mutate(year = path_file(filename) %>% 
           path_ext_remove() %>% 
           str_remove("storms_") %>% 
           as.double())
  



