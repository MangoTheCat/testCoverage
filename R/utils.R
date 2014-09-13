# SVN revision:   $
# Date of last change: 2013-09-29 $
# Last changed by: $LastChangedBy: ccampbell $
# 
# Original author: ttaverner
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################


# @title print text and then flush when verbose
# @param ... arguments to \code{cat}
# @param verbose single logical stating whether to print text and flush, or do nothing (default TRUE)
# @return NULL
fcat <- function(..., verbose = TRUE) {
  if (verbose) {
    cat(...)
    flush.console()
  }
}


# TODO: investigate left to right assignment
# @title test whether an object is an assign operator
# @param x an object
# @return logical
is.assign <- function(x) {
  if (identical(x, quote(`->`))) { warning("left to right assignment in parsed code") }
  identical(x, quote(`<-`)) || identical(x, quote(`=`)) || 
  identical(x, quote(`<<-`)) || identical(x, quote(`->`)) 
}


## we override the require function (!) so unit tests call the traced functions
# TODO: check this is really necessary - I dislike this a lot!
# TODO: fix fact that packagename is needed

#' @inheritParams base::require
#' @rdname testCoverage-mask
#' @export
require <- function(package, ...) {
  package <- as.character(substitute(package))
  doChar <- "character.only" %in% names(list(...))
  if (!exists("packagename")) 
    packagename <- "" 
  if(tolower(package) == tolower(packagename)) 
    cat("require(", package, ") ignored\n", sep = "")
  else {
  if (doChar)
    base::require(package = package, ...)
  else 
    base::require(package = package, ..., character.only = TRUE)
  }
}


#' @rdname testCoverage-mask
#' @export
library <- function(package, ...) {
  package <- as.character(substitute(package))
  if (!exists("packagename")) { packagename <- "" }
  if (tolower(package) == tolower(packagename)) 
    cat("require(", package, ") ignored\n", sep = "")
  else base::library(package = package, ..., character.only = TRUE)
}

# @title check whether function is in global environment, otherwise access from package
# @param pkg package name
# @param name function name
# @export

`namespace.ref` <- 
function (pkg, name) 
{
  
  pkg <- as.character(substitute(pkg))
  name <- as.character(substitute(name))
  if (exists(name, envir = .GlobalEnv)) { 
    get(name, envir = .GlobalEnv, inherits = FALSE)
  } else {
    get(name, envir = asNamespace(pkg), inherits = FALSE)
  }
}

#' @rdname testCoverage-mask
#' @export
data <- function(...) {
  m <- match.call()
  m[[1]] <- utils::data
  if (exists('packagename') && is.null(m$package)) {
    m$package <- as.character(packagename)
  }
  eval(m)
}
