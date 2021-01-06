# packages ----------------------------------------------------------------
library(tidyverse)

# description -------------------------------------------------------------
# plot a bar chart with the values on top of the bars, and with both the bars and labels dodged appropriately

# example -----------------------------------------------------------------

mtcars %>% 
  group_by(cyl, vs) %>% 
  summarise(n = n()) %>% 
  group_by(vs) %>% 
  mutate(freq = n / sum(n),
         cyl = factor(cyl),
         vs = factor(vs)) %>% 
  ggplot(aes(x = vs, y = freq, fill = cyl)) +
  geom_col(position = position_dodge(0.9)) +
  geom_text(aes(label = round(freq, 2)), 
            vjust = 2, 
            position = position_dodge(0.9),
            color = "white") +
  theme_minimal() +
  theme(line = element_blank(),
        axis.text.y = element_blank(),
        axis.title.y = element_blank())
