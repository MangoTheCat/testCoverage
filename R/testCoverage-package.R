#' testCoverage Package
#'
#' testCoverage is a package to report on the code coverage provided by a suite
#' of unit tests written in either testthat or RUnit.
#' 
#' HTML report output annotates source code with the coverage provided by 
#' various unit test files.
#'
#'
#' @author Mango Solutions\email{support@@mango-solutions.com}
#' @docType package
#' @name testCoverage-package
#' @seealso \code{\link{testCoverage}}, \code{\link{pkgCoverage}}, \code{\link{cranCoverage}}, 
#' \code{\link{selfCoverage}} and \code{vignette("testCoverage", package = "testCoverage")}
#' @examples
#' \dontrun{
#' demo(saturation)}
NULL

#' Masking function
#'
#' Not intended for direct use.
#' These functions complitments the instrumentation process by intercepting 
#' calls to functions of interest.
#' 
#' @param ... Parameters to pass onto the real function.
#' @keywords internal
#' @name testCoverage-mask
NULL

#' Internal function 
#'
#' Not intended for direct use.
#' These functions are internal to testCoverage's instrumentation process.
#' 
#' @keywords internal
#' @name testCoverage-internal
NULL


