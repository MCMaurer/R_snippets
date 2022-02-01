library(tidyverse)

# best way to do this

d <- tribble(
  ~species, ~low_1, ~high_1, ~low_2, ~high_2, ~shift,
  "PRLC", 180, 740, 180, 990, "expansion",
  "AMRE", 640, 690, 250, 780, "expansion",
  "PETH", 180, 990, 180, 840, "contraction",
  "PRBU", 180, 1000, 180, 1000, "no_change",
  "WOOF", 180, 500, 250, 600, "shift",
  "YIKE", 280, 600, 180, 500, "shift"
)

# basic steps here:
# find the range of the grey bars, which is the smallest high value and the biggest low value
# then some reshaping to get our data into a format where each species has 2 rows, one for the upper limits and one for the lower limits Each row has both time steps
# then we figure out the changes in upper and lower limits, and then decide whether those are expansions or contractions. If they're nothing, then we say they're NA
dd <- d %>% 
  mutate(grey_low = pmax(low_1, low_2), grey_high = pmin(high_1, high_2)) %>% 
  pivot_longer(cols = c(low_1, low_2, high_1, high_2)) %>% 
  separate(name, into = c("type", "time"), sep = "_") %>% 
  pivot_wider(names_from = time, values_from = value, names_prefix = "t") %>% 
  mutate(change = t2 - t1,
         change = case_when(
           type == "low" & change < 0 | type == "high" & change > 0 ~ "exp",
           type == "low" & change > 0 | type == "high" & change < 0 ~ "cont",
           TRUE ~ NA_character_
         )) 

dd

dd %>% 
  # x axis is species
  ggplot(aes(x = species, xend = species)) +
  # here we are plotting the expansions and contractions on both high and low limits
  geom_segment(aes(y = t1, yend = t2, color = change), size = 4) +
  # now we plot grey segments, based on the grey calculations we made earlier
  geom_segment(aes(y = grey_low, yend = grey_high), color = "grey80", size = 4) +
  scale_color_manual(values = c("red", "forestgreen")) +
  facet_wrap(vars(shift), nrow = 1, scales = "free_x") +
  theme(legend.position = "none")

# set up dataframe with low and high ranges for time 1 and low and high ranges for time 2, and whether or not that represents contraction or expansion
d <- tribble(
  ~species, ~low1, ~high1, ~low2, ~high2, ~expansion,
  "PRLC", 180, 740, 180, 990, "expansion",
  "AMRE", 640, 690, 250, 780, "expansion",
  "PETH", 180, 990, 180, 840, "contraction",
  "PRBU", 180, 1000, 180, 1000, "no_change"
)

theme_set(theme_minimal())

# easiest way to do this is actually to just plot a few different sets of geoms that overlap each other. this works nicely when there are range expansions in both directions

d %>% 
  ggplot(aes(x = species, xend = species)) +
  # first plot the green bars, these are NEW ranges so we use low2 and high2
  geom_segment(data = . %>% 
                 filter(expansion == "expansion"),
               aes(y = low2, yend = high2, color = expansion), size = 4, color = "forestgreen") +
  # now plot the gray bars that cover up parts of the green bars, using low1 and high1
  geom_segment(data = . %>% 
                 filter(expansion != "contraction"),
               aes(y = low1, yend = high1), size = 4, color = "grey80") +
  # now plot the red bars, these are actually the OLD ranges so we use low1 and high1
  geom_segment(data = . %>% 
                 filter(expansion == "contraction"),
               aes(y = low1, yend = high1, color = expansion), size = 4, color = "red") +
  # then plot the grey bars to cover them up, which are the NEW ranges, so we use low2 and high2
  geom_segment(data = . %>% 
                 filter(expansion == "contraction"),
               aes(y = low2, yend = high2), size = 4, color = "grey80") +
  facet_wrap(vars(expansion), nrow = 1, scales = "free_x")

# NOTE: this will NOT work if you have an expansion on one end of the range and a contraction on the other. you'd have to do something like below:

d <- tribble(
  ~species, ~low1, ~high1, ~low2, ~high2, ~expansion,
  "PRLC", 180, 740, 180, 990, "expansion",
  "AMRE", 640, 690, 250, 780, "expansion",
  "PETH", 180, 990, 180, 840, "contraction",
  "PRBU", 180, 1000, 180, 1000, "no_change",
  "WOOF", 180, 500, 250, 600, "shift_up"
)

d %>% 
  ggplot(aes(x = species, xend = species)) +
  # first plot the green bars, these are NEW ranges so we use low2 and high2
  geom_segment(data = . %>% 
                 filter(expansion == "expansion"),
               aes(y = low2, yend = high2, color = expansion), size = 4, color = "forestgreen") +
  # now plot the gray bars that cover up parts of the green bars, using low1 and high1
  geom_segment(data = . %>% 
                 filter(expansion %in% c("expansion", "no_change")),
               aes(y = low1, yend = high1), size = 4, color = "grey80") +
  # now plot the red bars, these are actually the OLD ranges so we use low1 and high1
  geom_segment(data = . %>% 
                 filter(expansion == "contraction"),
               aes(y = low1, yend = high1, color = expansion), size = 4, color = "red") +
  # then plot the grey bars to cover them up, which are the NEW ranges, so we use low2 and high2
  geom_segment(data = . %>% 
                 filter(expansion == "contraction"),
               aes(y = low2, yend = high2), size = 4, color = "grey80") +
  geom_segment(data = . %>% 
                filter(expansion == "shift_up"),
               aes(y = low1, yend = high1), size = 4, color = "red") +
  geom_segment(data = . %>% 
                 filter(expansion == "shift_up"),
               aes(y = low2, yend = high2), size = 4, color = "forestgreen") +
  geom_segment(data = . %>% 
                 filter(expansion == "shift_up"),
               aes(y = low2, yend = high1), size = 4, color = "grey80") +
  facet_wrap(vars(expansion), nrow = 1, scales = "free_x")

d <- tribble(
  ~species, ~low_1, ~high_1, ~low_2, ~high_2, ~expansion,
  "PRLC", 180, 740, 180, 990, "expansion",
  "AMRE", 640, 690, 250, 780, "expansion",
  "PETH", 180, 990, 180, 840, "contraction",
  "PRBU", 180, 1000, 180, 1000, "no_change",
  "WOOF", 180, 500, 250, 600, "shift",
  "YIKE", 280, 600, 180, 500, "shift"
)

# I kind of like this visualization
d %>%
  pivot_longer(cols = c(low_1, low_2, high_1, high_2)) %>%
  separate(name, into = c("type", "time"), sep = "_") %>%
  mutate(time = as.numeric(time)) %>%
  pivot_wider(names_from = type, values_from = value) %>%
  ggplot(aes(x = species, ymin = low, ymax = high, group = factor(time),
             color = if_else(time == 1, "original", expansion))) +
  geom_errorbar(position = position_dodge(width = 0.5), size = 3, width = 0) +
  scale_color_manual(values = c("red", "forestgreen", "grey80", "grey80", "blue", "blue")) +
  theme(legend.position = "none") +
  facet_wrap(vars(expansion), nrow = 1, scales = "free_x")


# d %>% 
#   pivot_longer(cols = c(low_1, low_2, high_1, high_2)) %>% 
#   separate(name, into = c("type", "time"), sep = "_") %>% 
#   mutate(time = as.numeric(time)) %>% 
#   pivot_wider(names_from = type, values_from = value) %>% 
#   ggplot(aes(x = species)) +
#   geom_point(aes(y = low), position = position_dodge(width = 0.5))
#   
#   
# d %>% 
#   pivot_longer(cols = c(low_1, low_2, high_1, high_2)) %>% 
#   separate(name, into = c("type", "time"), sep = "_") %>% 
#   mutate(time = as.numeric(time)) %>% 
#   pivot_wider(names_from = type, values_from = value) 
# 
# 
# d %>% 
#   mutate(low_change = low_2 - low_1,
#          high_change = high_2 - high_1,
#          color = case_when(
#            low_change < 0 | high_change > 0 ~ "forestgreen",
#            low_change > 0 | high_change < 0 ~ "red",
#            TRUE ~ "grey80"
#          )) %>% 
#   ggplot(aes(x = species, xend = species, color = color)) +
#   geom_segment(aes(y = low_1, yend = low_2), size = 4) +
#   geom_segment(aes(y = high_1, yend = high_2), size = 4) +
#   geom_segment(aes(y = pmax(low_1, low_2), yend = pmin(high_1, high_2)), 
#                color = "grey80", size = 4) +
#   scale_color_identity()


