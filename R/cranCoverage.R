#' Code coverage test packages from CRAN.
#'
#' \code{cranCoverage} downloads and computes the code coverage that bundled 
#' unit tests provides the package.
#'
#' This is for testing the latest releases of packages from CRAN.
#' 
#' The function will attempt to detect the directory and type of tests used if 
#' no \code{test.dir} parameter is passed. See \code{\link{reportCoverage}} for 
#' descriptions of additional parameters.
#'
#' @param packages character vector of package names currently available from 
#' CRAN.
#' @param test.dir character containing the relative file path to the tests 
#' directory.
#' @param ... parameters to pass onto reportCoverage
#' @return List containing coverage values and test enviroment. Side effect: A 
#' webpage of the report(s) will be opened.
#' @examples
#' \dontrun{
#' cranCoverage(c('zoo', 'stringr'))
#' }
#' @seealso \code{\link{reportCoverage}}, \code{\link{pkgCoverage}}, 
#' \code{\link{testCoverage}}
#' @author Mango Solutions\email{support@@mango-solutions.com}
#' @export
cranCoverage <- function(packages, test.dir = NULL, ...) {
  clear.Global <- function() {
    lst <- base::ls(all = TRUE, envir = .GlobalEnv)
    base::rm(list = lst[!(lst %in% old.Global)], envir = .GlobalEnv)
  }
  on.exit(clear.Global()) 

  executionL <- new.env(parent = emptyenv())
  old.Global <- ls(all.names = TRUE, envir = .GlobalEnv)

  for(package in packages) {
    clear.Global()

    test.result = try(cranCoverageHelper(package, 
        reportfile = sprintf('coverage_report_%s.html', package), 
        outputfile = sprintf('trace_%s.txt', package), 
        unittestdir = test.dir, ...), 
    silent = TRUE, ...)
    assign(package, test.result, envir = executionL)
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
  colnames(Coverage) <- 'Coverage'
  
  out <- list(Coverage = Coverage, env = executionL)
  return(out)
}

cranCoverageHelper <- function(x, unittestdir, reportfile, ...) {
  outpath <- getwd()
  on.exit(setwd(outpath))
  
  re <- in_dir(tempdir(), {

    # Download source from CRAN if not cached. ---------------------------------
    if (!is.a.dir(x)) {
      fn <- download.packages(x, '.', type = 'source')
      untar(fn[2])
    } else {
      fn <- c(basename(x), x)
    }

    if (!(s<-newSkeleton(fn[1]))$testable) {
      cat(sprintf(" %s is not a testable package\n", x))
      return(NULL)
    } 

    b = list(...)
    if (!is.null(s$testthats) || !is.null(s$additionaltests)) {

      if (!is.null(s$testthats)) 
        base::require('testthat')
        return(reportCoverage(
          packagename = fn[1], packagedir = fn[1], 
          unittestdir = file.path(fn[1], s$testthatdir),
          reportfile = paste0(gsub(".html$", "", reportfile), 
            "_internal.html"), ...))
      if (!is.null(s$additionaltests)) 
        return(reportCoverage(
          packagename = fn[1], packagedir = fn[1], unittestdir = unittestdir, 
          reportfile = paste0(gsub(".html$", "", reportfile), 
            "_additional.html"), ...))

    } else {

      sfs <- file.path(fn[1], 'R', s$R)

      if (!is.null(s$unittests))
        exfs <- file.path(fn[1], 'inst/unittests', s$unittests)
      else if (!is.null(s$extern.tests))
        exfs <- s$extern.tests
      else
        exfs <- file.path(fn[1], 'tests', s$tests)

      return(reportCoverage(packagedir = fn[1],
      sourcefiles = sfs, 
      executionfiles = exfs, 
      unittestdir = unittestdir, ...))
    }
  })
  invisible(re)
}
