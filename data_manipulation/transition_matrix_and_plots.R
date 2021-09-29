# packages ----------------------------------------------------------------
library(tidyverse)
library(tidygraph)
library(ggraph)

# description -------------------------------------------------------------
# take a dataset with state transitions according to user, turn them into a tidy set of transitions, then turn those transitions into edges on a graph and plot a transition matrix heatmap

# example -----------------------------------------------------------------

d <- tibble(user = c("user1", "user2", "user2", "user2", "user2", "user2", "user2"),
            mode = c("a", "a", "b", "c", "a", "c", "c")) %>% 
  group_by(user) %>% 
  mutate(next_mode = lead(mode)) %>% 
  replace_na(replace = list(next_mode = "none")) %>% 
  ungroup() %>% 
  count(mode, next_mode) %>% 
  group_by(mode) %>% 
  mutate(total_starts = sum(n),
         prob = n/total_starts)

d %>% 
  ggplot(aes(x = mode, y = next_mode)) +
  geom_tile(aes(fill = prob), color = "white") +
  theme_minimal()

tbl_graph(edges = d) %>% 
  ggraph(layout = "kk") +
  geom_edge_loop(aes(label = round(prob, 2)), 
                 arrow = arrow(),
                 start_cap = circle(5, 'mm'),
                 end_cap = circle(5, 'mm'),
                 angle_calc = "along",
                 label_dodge = unit(2, "mm")) +
  geom_edge_link(aes(label = round(prob, 2)), 
                 arrow = arrow(), 
                 start_cap = circle(5, 'mm'),
                 end_cap = circle(5, 'mm'),
                 angle_calc = "along",
                 label_dodge = unit(2, "mm")) +
  geom_node_label(aes(label = name), size = 4, alpha = 0.5) +
  theme_bw()