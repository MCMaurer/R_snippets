# packages ----------------------------------------------------------------

library(tidyverse)

# description -------------------------------------------------------------
# Label a stacked bar graph with the percentages of each category within the bar.

# example -----------------------------------------------------------------

d <- tibble(x = rep(1:2, 50), cat = rep(c("a", "b", "c", "d", "e"), 20), y = rpois(100, 2))

d %>% 
  group_by(x, cat) %>% 
  summarise(y = sum(y)) %>%
  ggplot(aes(x = x, y = y, fill = cat)) +
  geom_col(position = position_fill()) +
  geom_text(data = . %>% 
              group_by(x) %>% 
              mutate(p = y / sum(y)) %>% 
              ungroup(),
            aes(label = scales::percent(p)), 
            position = position_fill(vjust = 0.5))
