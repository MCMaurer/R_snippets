# packages ----------------------------------------------------------------
library(tidyverse)

# description -------------------------------------------------------------
# sometimes you want to fit a bunch of models with slightly different formulae

# example -----------------------------------------------------------------

d <- tibble(preds = names(mtcars)[-1]) %>% 
  rowwise() %>% 
  mutate(forms = list(formula(paste0("mpg ~ ", preds))),
         models = list(lm(forms, data = mtcars)),
         coefs = list(broom::tidy(models))) %>% 
  unnest(coefs)

d
