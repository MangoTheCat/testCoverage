# SVN revision:   $
# Date of last change: 2013-12-11 $
# Last changed by: $LastChangedBy: ccampbell $
# 
# Original author: ttaverner
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################


# orphan function
# TODO: Should change this to look at <Title> field
# Note that \code{httpdPort} should be available from \code{package:tools}
# @title extract package examples
# @param packagename string Package name.
# @return list of examples

extractPackageExamples <- function(packagename = "") {
  
  y <- list()
  
  if (packagename != "") {
    if (getAnywhere("httpdPort")[1] == 0L) {
      startDynamicHelp() }
    cat("Extracting package examples...\n")
    x <- lsf.str(paste0("package:", packagename))
    y <- sapply(x, extractExamples, packagename = packagename, 
      simplify = FALSE)
    y <- y[!duplicated(y) & !unlist(Map(identical, y, ""))]
    cat("OK.\n")
  }
  return(y)
}

# Note that \code{httpdPort} should be available from \code{package:tools}
# @title extract examples
# @param functionname string Function name.
# @param packagename string Package name.
# @return code

extractExamples <- function(functionname, packagename = "") {
  
  code <- ""
  
  if (packagename != "") {
    helpURL <- paste0("http://127.0.0.1:", 
      getAnywhere("httpdPort")[1], "/library/", packagename, "/html/", 
      functionname, ".html")
    helpText <- readLines(helpURL, warn = FALSE)
    exampleLocation <- grep("<h3>Examples</h3>|</body></html>", helpText)

    if (length(exampleLocation) == 2) {
      codeLocation <- exampleLocation + c(3, -4)
      code <- helpText[start = codeLocation[1]:codeLocation[2]]
      gsubcall <- function(arg, ...) { gsub(arg[1], arg[2], ...) }
      code <- Reduce(gsubcall, list(c("&amp;", "&"), c("&gt;", ">"), 
        c("&lt;", "<")), code, right = TRUE)
    }
    cat(" ", functionname, "\n")
    flush.console()
  }
  return(code)
}


# We assume examples are the last block, so this could fail otherwise
# @title extract rd examples 
# @param dirname string Path to .Rd files.
# @param packageexampledir string Path to extract examples to.
# @return list

extractRdExamples <- function(dirname, packageexampledir) {
  
  y <- list()
  
  rdFiles <- list.files(dirname, pattern = "*\\.Rd$")
  if (length(rdFiles) > 0) {
    cat("Extracting package examples...\n")
    sapply(rdFiles, function(fn) Rd2ex(file.path(dirname, fn), 
      out = file.path(packageexampledir, 
        paste0(gsub("(.*)[.]Rd$", "\\1", fn), ".R"))), simplify = FALSE)
    ## remove .Rd from names of output
    cat("OK.\n")
  }
  return(y)
}
