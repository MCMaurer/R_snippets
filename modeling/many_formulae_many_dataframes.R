# packages ----------------------------------------------------------------
library(tidyverse)

# description -------------------------------------------------------------
# sometimes you want to fit a bunch of models with slightly different formulae, but also against a nested column of tibbles

# example -----------------------------------------------------------------

# fake data
d <- tibble(row = 1:10) %>% 
  rowwise() %>% 
  mutate(data = list(mtcars %>% 
                       rownames_to_column() %>% 
           slice_sample(prop = 0.8))) %>% 
  unnest(data) %>% 
  nest(-row)

# dataframe of model names and formulae
forms <- list(weight = formula(mpg ~ wt),
     weight_cyl = formula(mpg ~ wt + cyl)) %>% 
  enframe(name = "model_name",
          value = "formula")

# fit model to each combo of formula and data
d %>% 
  expand_grid(forms) %>% 
  rowwise() %>% 
  mutate(models = list(lm(formula, data = data)),
         coefs = list(broom::tidy(models))) %>% 
  unnest(coefs)
