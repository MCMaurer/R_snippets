# packages ----------------------------------------------------------------
library(tools)

# description -------------------------------------------------------------
# a couple handy functions for taking a file path, pulling out the directory, file name, and even file without the extension, if you want to use the same name for an output of a different type

# example -----------------------------------------------------------------

file_path <- "ggplot/stacked_bar_percentages.R"

dirname(path)
basename(path)
paste0(file_path_sans_ext(path), ".txt")
file_path_as_absolute(path)
file_ext(path)
list_files_with_exts("data_manipulation", exts = c("R"))

