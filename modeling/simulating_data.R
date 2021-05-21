# packages ----------------------------------------------------------------
library(tidyverse)

# description -------------------------------------------------------------
# simulating data with group-level effects and continuous + categorical predictors

# example -----------------------------------------------------------------

set.seed(4)

d <- tibble(group = letters[1:5], 
            init_lambda = c(1, 2, 4, 8, 16)) %>% # each group gets a different initial lambda value, here they vary a lot
  expand_grid(dom_rank = c("dom", "mid", "sub")) %>% 
  mutate(lambda = case_when( # modify the lambda values slightly based on dominance rank
    dom_rank == "dom" ~ init_lambda * runif(1, 3, 3.4),
    dom_rank == "mid" ~ init_lambda * runif(1, 1.8, 2.3),
    dom_rank == "sub" ~ init_lambda * runif(1, 1, 1.1)
  )) %>% 
  group_by(group) %>% 
  slice_sample(n = sample(105:140, 1), replace = T) %>% # generate between 105 and 140 observations per group, with various dom_ranks
  ungroup() %>% 
  mutate(weight = rnorm(n(), mean = 15, sd = 2)) %>% # give the whole population normally distributed weights
  rowwise() %>% 
  mutate(lambda_f = lambda + 1.25*weight) %>% # modify the lambda based on weight
  mutate(bites = list(rpois(lambda = lambda_f, n = 1))) %>% # for each row, which corresponds to one observation, generate a single Poisson random variable using that row's lambda_f value, which incorporates effects of group, dom_rank, and weight
  unnest(bites)

d %>% 
  ggplot(aes(x = bites)) +
  geom_histogram() +
  facet_grid(rows = vars(group), cols = vars(dom_rank))

d %>% 
  ggplot(aes(x = weight, y = bites, color = dom_rank)) +
  geom_point() +
  facet_wrap(vars(group))
