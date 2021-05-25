# packages ----------------------------------------------------------------
library(magrittr)

# description -------------------------------------------------------------
# you can turn a pipeline into a one-argument function...

# example -----------------------------------------------------------------

1:10 %>% 
  mean() %>% 
  paste("The mean is", .)

print_mean <- . %>% 
  mean() %>% 
  paste("The mean is", .)

1:20 %>% 
  print_mean()

print_mean(1:20)

class(print_mean)

functions(print_mean)

