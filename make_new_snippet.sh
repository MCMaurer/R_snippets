#!/usr/bin/env bash

# the first argument is the category folder (with a backslash), the second is the name of the snippet

cp snippet_template.R "$1""$2".R
vim "$1""$2".R 
