# packages ----------------------------------------------------------------
library(tidyverse)

# description -------------------------------------------------------------
# base R approach to across(where())

# example -----------------------------------------------------------------

storms2 <- storms

s2tidy <- storms2 %>% 
  mutate(across(where(is.numeric), 
                list(scaled = ~as.vector(scale(.x)))))

match_cols <- colnames(storms2)[sapply(storms2, is.numeric)]

storms2[paste0(match_cols, "_scaled")] <- sapply(storms2[match_cols],
                                                function(x) as.vector(scale(x)))

all.equal(s2tidy, storms2)
