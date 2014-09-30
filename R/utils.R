# Date of last change: 2014-09-30 $
# Last changed by: $LastChangedBy: ttaverner $
# 
# Original author: ttaverner
# Copyright Mango Solutions, Chippenham, UK 2013-2014
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
  mc <- match.call()
  package <- tryCatch(eval.parent(as.list(mc)$package), error = function(e) as.character(as.list(mc)$package))
  if (!exists("packagename")) { packagename <- "" }
  if (tolower(package) == tolower(packagename)) {
    cat("require(", package, ") ignored\n", sep = "")
  } else {
    mc[[1]] <- quote(base::require)
    eval.parent(mc)
  }
}


#' @rdname testCoverage-mask
#' @export
library <- function(package, ...) {
  mc <- match.call()
  package <- tryCatch(eval.parent(as.list(mc)$package), error = function(e) as.character(as.list(mc)$package))
  if (!exists("packagename")) { packagename <- "" }
  if (tolower(package) == tolower(packagename)) {
    cat("library(", package, ") ignored\n", sep = "")
  } else {
    mc[[1]] <- quote(base::library)
    eval.parent(mc)
  }
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
