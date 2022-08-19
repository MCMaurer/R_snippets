# packages ----------------------------------------------------------------

library(tidyverse)

# description -------------------------------------------------------------
# Label a bar graph, but scale the positions of the labels based on how big the bar is. For big bars, labels go in the middle. For small bars, they go on the end

# example -----------------------------------------------------------------

d <- tibble(group = letters[1:5],
            counts = c(10, 100, 90, 200, 185)) %>% 
  mutate(pct = counts/sum(counts))

# this looks kinda bad, we'd like to put the labels inside, but the smallest bar is too small to fit a label
d %>% 
  ggplot(aes(x = counts, y = group)) +
  geom_col() +
  geom_text(aes(label = scales::percent(pct)))
            
# with this one, we say that for "small bars", which are less than 10% the size of the biggest bar, we put the label on top, by a distance of 5% of the biggest bar
d %>% 
  ggplot(aes(x = counts, y = group)) +
  geom_col() +
  geom_text(aes(label = scales::percent(pct), x = if_else(counts > 0.1*max(counts), counts/2, counts+ 0.05*max(counts))))

# we can do it slightly differently too, putting all labels as far left as possible, or on top of the bar. we use hjust to left-justify all labels, and nudge_x to push them off of 0 or the top of the bar by some small amount. we also modify the color of the label based on where it's going

d %>% 
  ggplot(aes(x = counts, y = group)) +
  geom_col() +
  geom_text(aes(label = scales::percent(pct), 
                x = if_else(counts > 0.1*max(counts), 0, counts),
                color = if_else(counts > 0.1*max(counts), "white", "black")),
            nudge_x = 0.01*max(d$counts), hjust = 0) +
  scale_color_identity() +
  theme_bw()
