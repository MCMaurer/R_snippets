# packages ----------------------------------------------------------------
library(tidyverse)
library(lubridate)

# description -------------------------------------------------------------
# this function allows you to get the lags for a given number of time steps, for a given number of columns. The example is from the MRC Locust tracking data, but the same general principle could be applied elsewhere. It's also a good use of partial() and tidyeval

# example -----------------------------------------------------------------

storms2 <- storms %>% 
  mutate(date = ymd_h(paste(year, month, day, hour)),
         storm_id = paste(name, year, sep = "_"))

get_lags <- function(.data, ..., lags = 1:5, by, time){
    .data %>% 
      group_by(!!ensym(by)) %>% 
      arrange(!!ensym(time)) %>% 
      mutate(across(
        .cols = c(!!!ensyms(...)),
        .fns = set_names(lags) %>%
          map(function(a) partial(lag, n = a)),
        .names = "{col}_lag{.fn}"
      )) %>% 
      ungroup()
}

storms2 %>% 
  get_lags(wind, pressure, lags = 1:4, by = storm_id, time = date) %>% 
  select(storm_id, date, starts_with("wind"), starts_with("pressure"))
