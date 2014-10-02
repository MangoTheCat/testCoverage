# SVN revision:   
# Date of last change: 2014-09-30
# Last changed by: ttaverner
# 
# Original author: ttaverner
# Copyright Mango Solutions, Chippenham, UK 2013-2014
###############################################################################

#' This function reports on the test coverage provided by a suite of unit tests
#' on a set of source files. Either a package or a disorganised set of files may
#' be used but if a package is being used the source must be available.
#' 
#' @title Low level function to perform code coverage test .
#' @param packagename Name of package. Optional if sourcefiles and executionfiles are specified instead.
#' @param packagedir Path to package directory. Optional if sourcefiles and executionfiles are specified instead.
#' @param htmlwd Directory to output HTML reports. Uses getwd() by default.
#' @param rdir Source code directory. Assumes \code{R/} if not specified.
#' @param unittestdir Unit test directory. Assumes \code{inst/tests/} if not specified.
#' @param sourcefiles Character vector of absolute file paths of source code. Optional if a package is specified.
#' @param executionfiles Character vector of absolute file paths of unit tests to run. Optional is a package is specified.
#' @param reportfile Report filename. "test.html" by default.
#' @param outputfile Output filename. "traceOutput.txt" by default.
#' @param ignorelist Ignore list. Empty by default.
#' @param clean Should trace tables be removed? FALSE by default.
#' @param writereport Should an HTML be created? Default is TRUE.
#' @param refnamespaces Vector of namespaces where ::: referecing should be 
#' intercepted. NULL by default.
#' @param isrunit Are the tests RUnit? Assumes testthat by default.
#' @param runitfileregexp Regexp to check runit filenames against.
#' @param runitfuncregexp Regexp to check runit function names against.
#' @return List where output$A contains a matrix of trace counts and output$B 
#' contains a sublist with counts for individual unit test files. 
#' @details
#' The source files and unit test files must be specified either by passing 
#' the \code{packagedir} parameter and letting the function use default folders or by
#' specifiying a vector of filenames in \code{sourcefiles} and \code{executionfiles}.
#' 
#' Generated HTML reports will be opened in the default browser. An internet 
#' connection is required to download external javascript resources that enable
#' code annotation.
#' 
#' @seealso \code{vignette("testCoverage", package = "testCoverage")}
#' @author Mango Solutions  \email{support@@mango-solutions.com}
#' @export
#' @import tools rjson
#' @examples
#' \dontrun{
#' reportCoverage(
#'  sourcefiles = system.file("examples/add/R/add.R", package = "testCoverage"), 
#'  executionfiles = system.file("examples/add/inst/tests/testthat/", 
#'   c("tests0/test_add0.R", "tests1/test_add1.R"), package = "testCoverage"))
#' 
#' #If the unit tests are in the inst/tests folder the unittestdir parameter is 
#' #unnecessary.
#' reportCoverage(
#'  packagedir = system.file("examples/add/", package = "testCoverage"), 
#'  unittestdir = system.file("examples/add/inst/tests/testthat/tests1", 
#'    package = "testCoverage"))
#' }

reportCoverage <- function(packagename = "", packagedir = getwd(), htmlwd = getwd(), 
  rdir = file.path(packagedir, "R"), unittestdir = file.path(packagedir, "inst", "tests"), 
  sourcefiles = NULL, executionfiles = NULL, reportfile = file.path(htmlwd, "coverage_report.html"), 
  outputfile = file.path(htmlwd, "traceOutput.txt"), ignorelist = "", 
  writereport = TRUE, clean = FALSE, verbose = TRUE, refnamespaces = NULL, 
  isrunit = FALSE, runitfileregexp = "^test_.+\\.[rR]$", runitfuncregexp = "^test.+") {
  
  # seek information about package
  
  if (!missing(packagename)) { 
    packagename <<- packagename 
  # also load required package
    lst = try(read.dcf( file.path(packagedir, 'DESCRIPTION')), silent = TRUE)
    if (!is(lst, 'try-error')){
      v = na.omit(unlist(strsplit(
        read.dcf(file.path(packagedir, 'DESCRIPTION'), 
          c('Depends', 'Imports')), ',')))
      v = gsub('\n', '', v)
      v = gsub('\\([^)(]*\\)', '', v)
      v = gsub('\\s+', '', v)
      v = v[v != 'R']
      for(i in v){
        try(base::require(i, character.only = TRUE), silent = TRUE)
      }
    }else {
      lst = try(tools::pkgDepends(packagename), silent = TRUE)
      if (!is(lst,'try-error')){
        for(i in lst$Depends){
          try(base::require(i, character.only = TRUE), silent = TRUE)
        }
      }
    }
  } else { packagename <<- "" }
  
  if (!missing(packagename)) {
    
    if (!missing(sourcefiles) | !is.null(sourcefiles))  
      warning("both packagename and sourcefiles provided") 
  }
  
  if (missing(sourcefiles) | is.null(sourcefiles)) { 
    lst = try(scan(textConnection(read.dcf(file.path(packagedir, 'DESCRIPTION'), 
      'Collate')), character(0), quiet = TRUE), silent = TRUE)
    if (!is(lst, 'try-error') && !is.na(lst) && length(lst)>0){
      sourcefiles <- file.path(rdir, lst)
    } else {
      sourcefiles <- list.files(rdir, full.names = TRUE) 
    }
  }
  
  if (length(sourcefiles) < 1) { stop("no source files selected") }
  
  if (missing(executionfiles) | is.null(executionfiles)) { 
    executionfiles <- list.files(unittestdir, pattern = "*[.][rR]$", 
      full.names = TRUE, all.files = TRUE) }
  
  if (length(executionfiles) < 1) { stop("no execution files selected") }
  
  if (isrunit) {
    tmp.dir <- tempdir()
    for (i in seq_along(executionfiles)) {
      tmp.executionfiles <- executionfiles[i]
      tmp.env <- new.env()
      source(tmp.executionfiles, local = tmp.env)
      possiblefuncs <- ls(envir = tmp.env)
      funcs <- possiblefuncs[sapply(possiblefuncs, 
        FUN = function(X) class(tmp.env[[X]]) == "function")]
      exelines <- readLines(tmp.executionfiles)
      exelines <- c(exelines, paste(funcs, "()", sep = ""))
      tmp.file <- file.path(tmp.dir, basename(tmp.executionfiles))
      writeLines(exelines, tmp.file)
      executionfiles[i] <- tmp.file
    }
  }
  
  sumTrace <- buildHTMLReport(sourcefiles = sourcefiles, 
    executionfiles = executionfiles, 
    reportfile = reportfile, 
	packagename = packagename, 
    outputfile = outputfile, 
    ignorelist = ignorelist, 
    writereport = writereport, 
    clean = clean, 
    verbose = verbose,
    refnamespaces = refnamespaces,
    isrunit = isrunit)
  
  return(sumTrace)
}
