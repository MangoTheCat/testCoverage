\name{cranCoverage}
\alias{cranCoverage}
\title{Code coverage test packages from CRAN.}
\usage{
cranCoverage(packages, test.dir = NULL, ...)
}
\arguments{
  \item{packages}{character vector of package names
  currently available from CRAN.}

  \item{test.dir}{character containing the relative file
  path to the tests directory.}

  \item{...}{parameters to pass onto reportCoverage}
}
\value{
List containing coverage values and test enviroment. Side
effect: A webpage of the report(s) will be opened.
}
\description{
\code{cranCoverage} downloads and computes the code
coverage that bundled unit tests provides the package.
}
\details{
This is for testing the latest releases of packages from
CRAN.

The function will attempt to detect the directory and type
of tests used if no \code{test.dir} parameter is passed.
See \code{\link{reportCoverage}} for descriptions of
additional parameters.
}
\examples{
\dontrun{
cranCoverage(c('zoo', 'stringr'))
}
}
\author{
Mango Solutions\email{support@mango-solutions.com}
}
\seealso{
\code{\link{reportCoverage}}, \code{\link{pkgCoverage}},
\code{\link{testCoverage}}
}

