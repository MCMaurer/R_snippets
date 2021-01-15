# packages ----------------------------------------------------------------
library(dplyr)
library(ggplot2)

# description -------------------------------------------------------------
# in a time series with gaps, it can be nice to fill in the gaps with dashed lines, but this can actually be kinda tricky

# example -----------------------------------------------------------------
test <- tibble(height = rexp(20, 10), time = 1:20)
test[c(4, 11, 12, 17, 19),1] <- NA

test %>% 
  mutate(gap = case_when((is.na(lag(height)) | 
                            is.na(lead(height))) & 
                           !is.na(height) & 
                           time != min(time) ~ TRUE,
                         (!is.na(lag(height)) | 
                            !is.na(lead(height))) & !is.na(height) ~ FALSE,
                         TRUE ~ NA),
         two_groups = is.na(lag(height)) & 
           is.na(lead(height)) & 
           time != min(time) & 
           time != max(time)) %>% 
  bind_rows(., filter(., two_groups)) %>% 
  arrange(time) %>% 
  group_by(gap) %>%
  mutate(group = ceiling(row_number()/2)) %>%
  ungroup() %>%
  mutate(gap = ifelse(gap, group, NA)) %>% 
  ggplot(aes(x = time, y = height)) +
  geom_point() +
  geom_line() +
  geom_line(data = . %>% filter(!is.na(height), gap > 0), aes(group = gap), lty = "dashed") +
  theme_bw()

