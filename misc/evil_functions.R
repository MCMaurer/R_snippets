# packages ----------------------------------------------------------------


# description -------------------------------------------------------------
# absolutely evil stuff to put in someone's .Rprofile

# example -----------------------------------------------------------------

attach(list(
  `+` = function(a, b){
    noquote(paste0(sum(a,b,rnorm(1,0,0.0001)), "ish"))
  },
  
  `(` = function(a){
    a*rnorm(1,1,0.001)
  },
  
  `<-` = function(a,b){
    warning("lol nah")
  },
  
  `/` = function(a,b){
    warning("divided we fall, truly words to live by")
  },
  
  library = function(package){
    warning("You have several overdue books and your library card has been revoked. Follow this link to reactivate: https://bit.ly/34hKSpu")
  }
), name = "JokeFunctions", warn.conflicts = FALSE)

(2)

x <- 3

2 + 2

4 / 5

library(tidyverse)
