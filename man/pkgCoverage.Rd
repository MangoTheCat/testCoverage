\name{pkgCoverage}
\alias{pkgCoverage}
\title{Code coverage test packages.}
\usage{
pkgCoverage(filepaths, test.dir = NULL, ...)
}
\arguments{
  \item{packages}{character vector of directory paths to
  package source directories.}

  \item{test.dir}{character containing the relative file
  path to the tests directory.}

  \item{...}{parameters to pass onto reportCoverage}
}
\value{
List containing coverage values and test enviroment. Side
effect: A webpage of the report(s) will be opened.
}
\description{
\code{pkgCoverage} computes the code coverage that a
packages's unit testing suite provides it.
}
\details{
This function is for package source directories.

The function will attempt to detect the directory and type
of tests used if no \code{test.dir} parameter is passed.
See \code{\link{reportCoverage}} for descriptions of
additional parameters.
}
\examples{
\dontrun{
pkgCoverage(
 filepaths = system.file("examples/add/", package = "testCoverage"),
 test.dir = "inst/tests/testthat/tests1")
}
}
\author{
Mango Solutions\email{support@mango-solutions.com}
}
\seealso{
\code{\link{reportCoverage}}, \code{\link{cranCoverage}},
\code{\link{testCoverage}}
}

