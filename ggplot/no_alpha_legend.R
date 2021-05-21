# packages ----------------------------------------------------------------
library(tidyverse)

# description -------------------------------------------------------------
# here's how to remove alpha from a legend so it's easier to read

# example -----------------------------------------------------------------

# can either put it into the scale function
mtcars %>%
	ggplot(aes(x = wt, y = mpg, color = as.factor(cyl))) +
	geom_point(alpha = 0.6) +
	scale_color_viridis_d(guide = guide_legend(override.aes = list(alpha = 1)))

# or you can include it in a guides layer
mtcars %>% 
  ggplot(aes(x = wt, y = mpg, shape = as.factor(cyl))) +
  geom_point(alpha = 0.2) +
  guides(shape = guide_legend(override.aes = list(alpha = 1)))


