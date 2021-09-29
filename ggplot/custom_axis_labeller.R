# packages ----------------------------------------------------------------
library(tidyverse)

# description -------------------------------------------------------------
# here's how to use a custom labeling function for an axis

# example -----------------------------------------------------------------

# define a formatter function to go from inches to feet + inches

footinch_formatter <- function(x) {
  foot <- floor(x/12)
  inch <- x %% 12
  return(paste0(foot, "'", inch, "\""))
}


tibble(height = rnorm(150, 60, 5)) %>% 
  ggplot(aes(x = height)) +
  geom_histogram() +
  scale_x_continuous(labels = footinch_formatter)
