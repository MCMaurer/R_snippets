library(tidyverse)
library(ggpomological)

p <- mtcars %>% 
  mutate(cyl = factor(cyl)) %>% 
  ggplot(aes(x = wt, y = mpg, color = cyl, group = cyl)) +
  geom_point(size = 3) +
  scale_color_pomological() +
  theme_pomological_fancy(base_size = 20) 

p %>% 
  paint_pomological(res = 130, width = 1500, height = 1000) %>% 
  magick::image_write(path = "~/Downloads/ggpomological-demo-painted.png")

