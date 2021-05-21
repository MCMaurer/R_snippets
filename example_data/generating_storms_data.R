library(tidyverse)
library(fs)

storms %>% 
  group_by(year) %>% 
  nest() %>% 
  pwalk(function(year, data)  write_csv(x = data, 
                                  file = paste0("example_data/storms_by_year/storms_", year, ".csv")))
