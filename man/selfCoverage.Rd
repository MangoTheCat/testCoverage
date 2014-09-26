\name{selfCoverage}
\alias{selfCoverage}
\title{Code coverage test example packages.}
\usage{
selfCoverage(testtype = c("testthat", "RUnit"),
  testthatpath = system.file(package = "testCoverage", "tests", "testthat"),
  runitpath = system.file(package = "testCoverage", "tests", "RUnit"),
  reporthtml = FALSE, printtestprotocol = FALSE)
}
\arguments{
  \item{testtype}{Either 'testthat' or 'RUnit' to select a
  testing framework.}

  \item{testthatpath}{Path to unit test files.  Package
  directory "tests/testthat" by default.}

  \item{runitpath}{Path to unit test files.  Package
  directory "tests/RUnit" by default.}

  \item{reporthtml}{Should HTML reports be generated? FALSE
  by default. Warning: This will open a lot of tabs in your
  browser.}

  \item{printtestprotocol}{Should an RUnit HTML reports be
  generated? FALSE by default.}
}
\value{
The results of executing the test suites via the function
\code{selfCoverage}.
}
\description{
Run included package regression tests.
}
\details{
Executes the package regression tests, and optionally
produces an html report. Both RUnit and testthat tests are
available.
}
\examples{
#Use demo(unittest) to run these tests.
\dontrun{
selfCoverage(testtype = "RUnit")
selfCoverage(testtype = "testthat")
}
}
\author{
Mango Solutions\email{support@mango-solutions.com}
}
\keyword{debugging}

