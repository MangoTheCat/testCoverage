#' Code coverage test files.
#'
#' \code{testCoverage} computes the code coverage that a unit test suite provides
#' a set of source files.
#'
#' This function is for testing disorganised source files for packages helper 
#' functions are available.
#' 
#' testthat tests are assumed by default, otherwise see 
#' \code{\link{reportCoverage}} for the necessary parameters.
#'
#' @param source.files character vector of source code filenames
#' @param test.files character vector of unit test filenames
#' @param ... parameters to pass onto reportCoverage
#' @return A list containing summary coverage, errors and individual coverage.
#'  Side effect: A webpage of the report will be opened.
#'
#' @examples
#' \dontrun{
#' testCoverage(
#'  system.file("examples/add/R/add.R", package = "testCoverage"), 
#'  system.file("examples/add/inst/tests/testthat/", 
#'   c("tests0/test_add0.R", "tests1/test_add1.R"), package = "testCoverage"))
#' }
#' @seealso \code{\link{reportCoverage}}, \code{\link{pkgCoverage}}, 
#' \code{\link{cranCoverage}}
#' @author Mango Solutions\email{support@@mango-solutions.com}
#' @export
testCoverage <- function(source.files=dir("R", full=TRUE), test.files=dir("tests/testthat/", full=TRUE), ...) {
  if(any(grepl("testthat", test.files))) {
    if(!require(testthat)) stop("Package 'testthat' must be installed and loaded.")
    orig_dir <- getwd()
    source.files <- file.path(orig_dir, source.files)
    test.files <- file.path(orig_dir, test.files)
    setwd(file.path("tests", "testthat"))
  }
  res <- reportCoverage(sourcefiles = source.files, executionfiles = test.files, ...)
  setwd(orig_dir)
  res
}