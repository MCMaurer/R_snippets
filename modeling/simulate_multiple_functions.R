# packages ----------------------------------------------------------------
library(tidyverse)

# description -------------------------------------------------------------
# using invoke_map() to call entirely different functions with different inputs
# example from here: https://r4ds.had.co.nz/many-models.html?q=nest#from-vectorised-functions

# example -----------------------------------------------------------------

sim <- tribble(
  ~f,      ~params,
  "runif", list(min = -10, max = 10),
  "rnorm", list(sd = 5),
  "rpois", list(lambda = 5)
)

sim %>%
  mutate(sims = invoke_map(f, params, n = 1000)) %>% 
  unnest(sims) %>% 
  ggplot(aes(x = sims)) +
  geom_histogram() +
  facet_wrap(vars(f), ncol = 1)
