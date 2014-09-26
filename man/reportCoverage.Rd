\name{reportCoverage}
\alias{reportCoverage}
\title{Low level function to perform code coverage test .}
\usage{
reportCoverage(packagename = "", packagedir = getwd(), htmlwd = getwd(),
  rdir = file.path(packagedir, "R"), unittestdir = file.path(packagedir,
  "inst", "tests"), sourcefiles = NULL, executionfiles = NULL,
  reportfile = file.path(htmlwd, "coverage_report.html"),
  outputfile = file.path(htmlwd, "traceOutput.txt"), ignorelist = "",
  writereport = TRUE, clean = FALSE, refnamespaces = NULL,
  isrunit = FALSE, runitfileregexp = "^test_.+\\\\.[rR]$",
  runitfuncregexp = "^test.+")
}
\arguments{
  \item{packagename}{Name of package. Optional if
  sourcefiles and executionfiles are specified instead.}

  \item{packagedir}{Path to package directory. Optional if
  sourcefiles and executionfiles are specified instead.}

  \item{htmlwd}{Directory to output HTML reports. Uses
  getwd() by default.}

  \item{rdir}{Source code directory. Assumes \code{R/} if
  not specified.}

  \item{unittestdir}{Unit test directory. Assumes
  \code{inst/tests/} if not specified.}

  \item{sourcefiles}{Character vector of absolute file
  paths of source code. Optional if a package is
  specified.}

  \item{executionfiles}{Character vector of absolute file
  paths of unit tests to run. Optional is a package is
  specified.}

  \item{reportfile}{Report filename. "test.html" by
  default.}

  \item{outputfile}{Output filename. "traceOutput.txt" by
  default.}

  \item{ignorelist}{Ignore list. Empty by default.}

  \item{clean}{Should trace tables be removed? FALSE by
  default.}

  \item{writereport}{Should an HTML be created? Default is
  TRUE.}

  \item{refnamespaces}{Vector of namespaces where :::
  referecing should be intercepted. NULL by default.}

  \item{isrunit}{Are the tests RUnit? Assumes testthat by
  default.}

  \item{runitfileregexp}{Regexp to check runit filenames
  against.}

  \item{runitfuncregexp}{Regexp to check runit function
  names against.}
}
\value{
List where output$A contains a matrix of trace counts and
output$B contains a sublist with counts for individual unit
test files.
}
\description{
This function reports on the test coverage provided by a
suite of unit tests on a set of source files. Either a
package or a disorganised set of files may be used but if a
package is being used the source must be available.
}
\details{
The source files and unit test files must be specified
either by passing the \code{packagedir} parameter and
letting the function use default folders or by specifiying
a vector of filenames in \code{sourcefiles} and
\code{executionfiles}.

Generated HTML reports will be opened in the default
browser. An internet connection is required to download
external javascript resources that enable code annotation.
}
\examples{
\dontrun{
reportCoverage(
 sourcefiles = system.file("examples/add/R/add.R", package = "testCoverage"),
 executionfiles = system.file("examples/add/inst/tests/testthat/",
  c("tests0/test_add0.R", "tests1/test_add1.R"), package = "testCoverage"))

#If the unit tests are in the inst/tests folder the unittestdir parameter is
#unnecessary.
reportCoverage(
 packagedir = system.file("examples/add/", package = "testCoverage"),
 unittestdir = system.file("examples/add/inst/tests/testthat/tests1", package = "testCoverage"))
}
}
\author{
Mango Solutions \email{support@mango-solutions.com}
}
\seealso{
\code{vignette("testCoverage", package = "testCoverage")}
}

