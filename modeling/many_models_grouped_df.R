# packages ----------------------------------------------------------------
library(tidyverse)

# description -------------------------------------------------------------
# fitting models to a grouped data.frame, similar to the group_by %>% nest %>% map approach

# example -----------------------------------------------------------------

m <- storms %>% 
  group_by(year) %>% 
  group_modify(possibly(
    ~lm(hu_diameter ~ pressure + wind,
        data = .x) %>% 
      broom::tidy(conf.int = T),
    otherwise = tibble(NULL))
  ) 

m %>% 
  ggplot(aes(x = year, y = estimate)) +
  geom_line() +
  geom_ribbon(aes(ymin = conf.low,
                  ymax = conf.high),
              alpha = 0.2) +
  facet_wrap(vars(term), scales = "free", ncol = 1)

# using nest and map

storms %>% 
  group_by(year) %>% 
  nest() %>% 
  mutate(model = map(data, possibly(
    ~lm(hu_diameter ~ pressure + wind,
        data = .x) %>% 
      broom::tidy(conf.int = T),
    otherwise = tibble(NULL)
  ))) %>% 
  unnest(model) %>% 
  ggplot(aes(x = year, y = estimate)) +
  geom_line() +
  geom_ribbon(aes(ymin = conf.low,
                  ymax = conf.high),
              alpha = 0.2) +
  facet_wrap(vars(term), scales = "free", ncol = 1)
