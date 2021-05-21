#!/usr/bin/env bash

# the first argument is the category folder (with a backslash), the second is the name of the snippet

if [[ "$1" == "rmarkdown/" ]]
then
cp rmarkdown_template.Rmd "$1""$2".Rmd
vim "$1""$2".Rmd
else
cp snippet_template.R "$1""$2".R
vim "$1""$2".R 
fi
