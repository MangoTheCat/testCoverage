\name{testCoverage}
\alias{testCoverage}
\title{Code coverage test files.}
\usage{
testCoverage(sourcefiles, testfiles, ...)
}
\arguments{
  \item{sourcefiles}{character vector of source code
  filenames}

  \item{testfiles}{character vector of unit test filenames}

  \item{...}{parameters to pass onto reportCoverage}
}
\value{
A list containing summary coverage, errors and individual
coverage.  Side effect: A webpage of the report will be
opened.
}
\description{
\code{testCoverage} computes the code coverage that a unit
test suite provides a set of source files.
}
\details{
This function is for testing disorganised source files for
packages helper functions are available.

testthat tests are assumed by default, otherwise see
\code{\link{reportCoverage}} for the necessary parameters.
}
\examples{
\dontrun{
testCoverage(
 system.file("examples/add/R/add.R", package = "testCoverage"),
 system.file("examples/add/inst/tests/testthat/",
  c("tests0/test_add0.R", "tests1/test_add1.R"), package = "testCoverage"))
}
}
\author{
Mango Solutions\email{support@mango-solutions.com}
}
\seealso{
\code{\link{reportCoverage}}, \code{\link{pkgCoverage}},
\code{\link{cranCoverage}}
}

