# packages ----------------------------------------------------------------

library(tidyverse)


# description -------------------------------------------------------------

# use label_wrap_gen() to automatically wrap long axis labels
# way better than flipping axes or other methods

# example -----------------------------------------------------------------


storms %>% 
  count(status) %>% 
  ggplot(aes(x = status, y = n)) +
  geom_col() +
  scale_x_discrete(label = label_wrap_gen(10))
