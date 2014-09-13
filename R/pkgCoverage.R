#' Code coverage test packages.
#'
#' \code{pkgCoverage} computes the code coverage that a packages's unit testing 
#' suite provides it.
#' 
#' This function is for package source directories.
#'
#' The function will attempt to detect the directory and type of tests used if 
#' no \code{test.dir} parameter is passed. See \code{\link{reportCoverage}} for 
#' descriptions of additional parameters.
#'
#' @param packages character vector of directory paths to package source 
#' directories.
#' @param test.dir character containing the relative file path to the tests 
#' directory.
#' @param ... parameters to pass onto reportCoverage
#' @return List containing coverage values and test enviroment. Side effect: A 
#' webpage of the report(s) will be opened.
#' @examples
#' \dontrun{
#' pkgCoverage(
#'  filepaths = system.file("examples/add/", package = "testCoverage"), 
#'  test.dir = "inst/tests/testthat/tests1")
#' }
#' @seealso \code{\link{reportCoverage}}, \code{\link{cranCoverage}}, 
#' \code{\link{testCoverage}}
#' @author Mango Solutions\email{support@@mango-solutions.com}
#' @export
pkgCoverage <- function(filepaths, test.dir = NULL, ...) {
  clear.Global <- function() {
    lst <- base::ls(all = TRUE, envir = .GlobalEnv)
    base::rm(list = lst[!(lst %in% old.Global)], envir = .GlobalEnv)
  }
  on.exit(clear.Global()) 

  executionL <- new.env(parent = emptyenv())
  old.Global <- ls(all.names = TRUE, envir = .GlobalEnv)

  for(path in filepaths) {
    clear.Global()

    test.result <- try(pkgCoverageHelper(path, 
        reportfile = sprintf('coverage_report_%s.html', basename(path)), 
        outputfile = sprintf('trace_%s.txt', basename(path)), 
        unittestdir = test.dir), silent = TRUE, ...)

    assign(basename(path), test.result, envir = executionL)
  }
  Coverage <- as.matrix(eapply(executionL, function(x) {
    re <- if (is(x, 'try-error')) 
      0 
    else 
      sum(x$A[-1, ])/sum(x$A[1, ])
    
    if (is.nan(re)) 
      re = 0

    re
  }))
  colnames(Coverage) = 'Coverage'
  re = list(Coverage = Coverage, env = executionL)
  return(re)
}

pkgCoverageHelper <- function(x, unittestdir, reportfile, ...) {
  outpath <- getwd()
  on.exit(setwd(outpath))

  if (!(s<-newSkeleton(x, unittestdir))$testable) {
    cat(sprintf(" %s is not a testable package\n", x))
    return(NULL)
  }

  in_dir(outpath, { # avoid possible change of working dir, e.g. MASS
    if (!is.null(s$testthats) || !is.null(s$additionaltests)) {
      if (!is.null(s$testthats)) 
        re <- reportCoverage(packagename = basename(x), packagedir = x, 
          reportfile = paste0(gsub(".html$", "", reportfile), "_internal.html"), 
          ...)

      if (!is.null(s$additionaltests)) 
        re <- reportCoverage( packagename = basename(x), packagedir = x, 
          unittestdir = file.path(x, unittestdir), reportfile = paste0(gsub(".html$", "", 
            reportfile), "_additional.html"), 
        ...)
    } else {
      sfs <- file.path(x,'R',s$R)

      if (!is.null(s$unittests))
        exfs <- file.path(x,'inst/unittests',s$unittests)
      else if (!is.null(s$extern.tests))
        exfs <- s$extern.tests
      else
        exfs <- file.path(x,'tests',s$tests)

      re <- reportCoverage(packagename = basename(x), sourcefiles = sfs,
        executionfiles = exfs , unittestdir = file.path(x, unittestdir), ...)
    }
  })
  
  invisible(re)
}