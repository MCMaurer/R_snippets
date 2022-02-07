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

# this function will get correlations between the original variable and every lag OR between a comp_var and every lag + the original

make_lag_corr <- function(.data, ..., lags = 1:5, by, time, comp_var){
  x <- .data %>% 
    select(!!!ensyms(...), !!ensym(by), !!ensym(time), !!ensym(comp_var)) %>% 
    get_lags(... = ..., lags = lags, by = !!ensym(by), time = !!ensym(time)) %>% 
    select(-!!ensym(by), -!!ensym(time)) %>% 
    relocate(!!ensym(comp_var)) %>% 
    cor(use = "pairwise.complete.obs") %>% 
    as.data.frame() %>% 
    select(1) %>% 
    rename_with(~paste0(.x, "_corr")) 
  
  if(nrow(x) > length(lags)+1){
    x %>% 
      mutate(lag = c(NA, 0, lags)) %>% 
      .[-1,]
  } else{
    x %>% 
    mutate(lag = c(0,lags))
  }
}

storms2 %>% 
  make_lag_corr(wind, lags = 1:4, by = storm_id, time = date, comp_var = pressure)

storms2 %>% 
  make_lag_corr(wind, lags = 1:4, by = storm_id, time = date)
