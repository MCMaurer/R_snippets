source("renv/activate.R")

# remove this stuff if you just want to use renv
if ("RSTUDIO" %in% names(Sys.getenv())){
options(max.print = 999)
options(prompt = "|> ")
options(continue = "...")
}

if (requireNamespace("rlang", quietly = TRUE)) {
	options(
   rlang_backtrace_on_error = "full",
   error = rlang::entrace
 )
}

## WORKAROUND: https://github.com/rstudio/rstudio/issues/6692
## Revert to 'sequential' setup of PSOCK cluster in RStudio Console on macOS and R 4.0.0
if (Sys.getenv("RSTUDIO") == "1" && !nzchar(Sys.getenv("RSTUDIO_TERM")) && 
    Sys.info()["sysname"] == "Darwin" && getRversion() == "4.0.0") {
  parallel:::setDefaultClusterOptions(setup_strategy = "sequential")
}
