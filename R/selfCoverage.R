# SVN revision:   $
# Date of last change: 2013-12-11 $
# Last changed by: $LastChangedBy: ccampbell $
# 
# Original author: jjxie
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################

#' Run included package regression tests.
#'
#' Executes the package regression tests, and optionally produces an html report. 
#' Both RUnit and testthat tests are available.
#' @title Code coverage test example packages.
#' @param testtype Either 'testthat' or 'RUnit' to select a testing framework.
#' @param testthatpath Path to unit test files.  Package directory "tests/testthat" by default.
#' @param runitpath Path to unit test files.  Package directory "tests/RUnit" by default.
#' @param reporthtml Should HTML reports be generated? FALSE by default. Warning: This will open a lot of tabs in your browser.
#' @param printtestprotocol Should an RUnit HTML reports be generated? FALSE by default.
#' @return The results of executing the test suites via the function \code{selfCoverage}. 
#' @export
#' @author Mango Solutions\email{support@@mango-solutions.com}
#' @keywords debugging
#' @examples
#' #Use demo(unittest) to run these tests.
#' \dontrun{
#' selfCoverage(testtype = "RUnit")
#' selfCoverage(testtype = "testthat")
#' }

selfCoverage <- function(testtype = c("testthat", "RUnit"), 
		testthatpath = system.file(package = "testCoverage", "tests", "testthat"), 
		runitpath = system.file(package = "testCoverage", "tests", "RUnit"),
		reporthtml = FALSE, printtestprotocol = FALSE)
{
	testtype <- match.arg(testtype)
	options(testCoverageIsReport = reporthtml)
	
	if (testtype == "testthat") {
		stopifnot(require(testthat, quietly = TRUE))
		res <- test_dir(testthatpath)
	}
	
	if (testtype == "RUnit") {
		stopifnot(require(RUnit, quietly = TRUE))
		testSuite <- defineTestSuite("testCoverage unit test suite", 
			dirs = runitpath, testFileRegexp = "^test_.+\\.[rR]$")
		res <- runTestSuite(testSuite)
		if(printtestprotocol) printHTMLProtocol(res, 
			fileName = "testCoverage_RUnit.html" )
	}
	
	return(res)
}

#' @keywords internal
#' @export
runTests <- function(...) {
  .Deprecated("selfCoverage")
  selfCoverage(...)
}
