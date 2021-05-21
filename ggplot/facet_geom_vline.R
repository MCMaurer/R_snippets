# packages ----------------------------------------------------------------

library(tidyverse)

# description -------------------------------------------------------------
# this shows how you can create geom_vlines to denote events in time, and have them correspond to specific facets, such as countries here. Very nice programmatic way to annotate events. 

# Real-world use would probably be something like having a dates + countries + counts dataframe, and then having a dates + countries + event names dataframe, and then joining them together. Although I do think you would still need to make a separate event_date column, but that would be quite easy

# example -----------------------------------------------------------------

date <- seq(as.Date("2020-11-01"), as.Date("2020-11-30"), by="days")

d <- expand_grid(date, country = c("USA", "Canada"))

d$event_date <- as.Date(NA)
d$event_date[3] <- d$date[3]

d$event_date[20] <- d$date[20]

d$event_name <- as.character(NA)
d$event_name[3] <- "lockdown_USA"

d$event_name[20] <- "lockdown_Canada"

d$count <- sample(1:10, 60, replace = T)

d

d %>% 
  ggplot(aes(x = date, y = count)) +
  geom_line() +
  geom_vline(aes(xintercept = event_date), linetype = 2, color = "red") +
  geom_text(aes(x = event_date + 3, y = 1, label = event_name), color = "red") +
  facet_wrap(vars(country)) +
  theme_bw()

