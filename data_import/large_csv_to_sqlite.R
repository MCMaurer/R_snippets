# packages ----------------------------------------------------------------
library(tidyverse)
library(DBI)
library(RSQLite)
library(fs)
library(vroom)

# description -------------------------------------------------------------

# if you have a massive CSV that is too large to fit in R's memory, this is a way to turn it into an SQLite database without ever reading the whole thing into R's memory.

# example -----------------------------------------------------------------

mydb <- DBI::dbConnect(RSQLite::SQLite(), "example_data/storms.sqlite3")

tf <- file_temp(ext = "csv")
storms %>% 
  write_csv(tf)

nrow_csv <- length(vroom::vroom_lines(tf, progress = FALSE)) - 1L

tbl_p <- possibly(tbl, otherwise = data.frame())

# if the database doesn't contain anything, tbl() won't find "storms", so you get a blank data.frame, which will return a value of 0 here. if the database contains values, this will find the number of rows in the "storms" table
nrow_db <- tbl_p(mydb, "storms") %>% summarise(n = n()) %>% collect() %>% pull(n)

if(nrow_db != 0 & nrow_db != nrow_csv){
  stop("DB not empty, but the number of rows does not match the CSV.")
} else {
  if(nrow_db == 0){
    read_csv_chunked(tf, callback = function(chunk, dummy){
      DBI::dbWriteTable(mydb, "storms", chunk, append = T)
    }, chunk_size = 1000, col_types = "cddidddciiidd")
  }
}

tbl(mydb, "storms")

tbl(mydb, "storms") %>% 
  filter(year == 1980) %>% 
  collect()

tbl_p(mydb, "storms") %>% summarise(n = n()) %>% collect() %>% pull(n)

tbl_p(mydb, "storms") %>% summarise(n = n()) %>% collect() %>% pull(n) == nrow_csv

storms2 <- tbl(mydb, "storms") %>% collect()

#SQL can't store factors
all.equal(storms, storms2)