library(tidyverse)
library(fs)

storms %>% 
  group_by(year) %>% 
  nest() %>% 
  pwalk(function(year, data)  write_csv(x = data, 
                                  file = paste0("example_data/storms_by_year/storms_", year, ".csv")))


# making sqlite DB --------------------------------------------------------

library(nycflights13)

db_location <- "example_data/nycflights13.sqlite3"

mydb <- DBI::dbConnect(RSQLite::SQLite(), db_location)

copy_to(mydb, airlines, temporary = F)
copy_to(mydb, airports, temporary = F)
copy_to(mydb, flights, temporary = F)
copy_to(mydb, planes, temporary = F)
copy_to(mydb, weather, temporary = F)

airlines <- tbl(mydb, "airlines")


