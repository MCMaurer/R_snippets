# packages ----------------------------------------------------------------
library(fs)
library(tidyverse)

# description -------------------------------------------------------------
# using the fs package to work with temporary files

# example -----------------------------------------------------------------

# look at what's in the temp directory
path_temp() %>% 
  dir_ls()

# create a new folder in the temp folder
new_temp <- file_temp("my_new_temp_folder_") %>% 
  dir_create()

new_temp

# check to see that it's there
path_temp() %>% 
  dir_ls()

# generate a bunch of CSV file paths
paths <- new_temp %>% 
  path(letters[1:5], ext = "csv")

# make files with those paths
paths %>% 
  file_create()

new_temp %>% 
  dir_ls()

# get the file names of the paths, remove the extensions
paths %>% 
  path_file() %>% 
  path_ext_remove()

# make .txt files to match all the .csv files, and create them
paths %>% 
  path_ext_set(".txt") %>% 
  file_create()

new_temp %>% 
  dir_ls()
