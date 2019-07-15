### . library paths w/unc drives ----

## r version information
r = R.Version()
patch = paste(r$major, r$minor, sep = ".")
minor = regmatches(patch, regexpr("^[0-9]{+}\\.[0-9]{+}", patch))

## local library
lcl = file.path("C:/Users/florianD/R/win-library", minor)
if (!dir.exists(lcl)) dir.create(lcl, recursive = TRUE)

## global library (pre-installed)
gbl = paste0("C:/Program Files/R/R-", patch, "/library")

## set library paths
.libPaths(c(lcl, gbl))


### . console prompt ----

jnk = if (!require(prompt, quiet = TRUE)) {
  try(utils::install.packages("prompt"), silent = TRUE)
} else TRUE

if (!inherits(jnk, "try-error")) {
  prompt::set_prompt(paste0("[", prompt::git_branch(), "]> "))
}

## clean workspace
rm(list = ls(all = TRUE))
