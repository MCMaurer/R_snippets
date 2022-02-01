library(tidyverse)
library(broom)
library(gganimate)

theme_set(theme_minimal())

# do it once
slice_sample(mtcars, prop = 0.8, replace = T) %>% 
  lm(mpg ~ wt, data = .) %>% 
  tidy()

# if you run that code repeatedly, you get different samples and different estimates

# you can use map to do an operation an arbitrary number of times
# the values of 1:100 don't actually matter here
# this will just repeat the process 100 times
folds <- map(1:100, ~slice_sample(mtcars, prop = 0.8, replace = T))

# now we will map across our folds
# we want to apply the same linear model to each fold
# here we actually use the current fold element, with the .x
map(folds, ~lm(mpg ~ wt, data = .x))

# now we have 100 linear models and we want to tidy each of them
# once they are tidy tibbles, it's nicer to have them in a single dataframe
# we can use map_dfr to accomplish that, with the list ID (1:100) in a column called iter
map(folds, ~lm(mpg ~ wt, data = .x)) %>% 
  map_dfr(.f = tidy, .id = "iter")

# let's save that
m <- map(folds, ~lm(mpg ~ wt, data = .x)) %>% 
  map_dfr(.f = tidy, .id = "iter")

# now we can make a density plot of the 100 estimates for each parameter
m %>% 
  ggplot(aes(x = estimate)) +
  geom_density() +
  facet_wrap(vars(term), scales = "free")

# accumulate and plot density animation -----------------------------------

# next let's look at how a bootstrap estimate for the weight beta value changes as we add more samples

# this time we want a list of tidy tibbles, not collapsed into one dataframe
# so we can actually apply the lm + tidy to each fold, then just get the rows + cols we want
m <- map(folds, 
         ~lm(mpg ~ wt, data = .x) %>% 
           tidy() %>% 
           filter(term == "wt") %>% 
           select(term, estimate)
         )

# next we will use accumulate! here is a little demo of how this works
accumulate(1:10, `+`)

# accumulate takes the first value and applies the function, then takes that result and applies the function to it and the next value, and so on
# so if we run accumulate on our list of tidy tibbles, with the function bind_rows, it will generate a "rolling" dataframe. so the first dataframe only has the first wt value, the second has the first two, etc.
accumulate(m, bind_rows)

# now we can bind together this list of dataframes, and use a column iter to keep track of which iteration we're on
accumulate(m, bind_rows) %>% 
  bind_rows(.id = "iter")

# as you can see, there is one row for iter 1, two rows for iter 2, three rows for iter 3, etc.
# let's save this, and also turn iter into a numeric variable from character
d <- accumulate(m, bind_rows) %>% 
  bind_rows(.id = "iter") %>% 
  mutate(iter = as.numeric(iter))

# now we can use ggplot2 and the gganimate package to make an animation, where each frame is a density plot of wt values from an iteration
a <- d %>% 
  filter(term == "wt") %>% 
  ggplot(aes(x = estimate)) +
  geom_density() +
  theme(panel.grid = element_blank(), axis.text = element_blank()) +
  transition_time(iter) +
  ggtitle("Cumulative # of samples: {frame_time}") +
  view_follow(fixed_x = T)

animate(a, fps = 5)

anim_save("modeling/bootstrap_with_map.gif", animation = a, fps = 5)
