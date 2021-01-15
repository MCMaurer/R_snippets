# packages ----------------------------------------------------------------
library(tidyverse)
library(MCMsBasics)


# description -------------------------------------------------------------
# use the Tufte approach of overlaying grid lines that match the background on top of the bars. You then get the grid lines showing up on top of the bars themselves, which reduces clutter and also gives you a very direct look at where each bar falls.

# example -----------------------------------------------------------------


mtcars %>% 
  group_by(cyl) %>% 
  summarise(mpg = mean(mpg)) %>% 
  mutate(cyl = factor(cyl)) %>% 
  ggplot(aes(x = cyl, y = mpg)) +
  geom_col() +
  minimal_ggplot_theme() +
  theme(panel.ontop = T,
        panel.grid.major.y = element_line(color = "white"))
