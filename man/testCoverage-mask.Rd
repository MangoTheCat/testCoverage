\name{testCoverage-mask}
\alias{data}
\alias{library}
\alias{require}
\alias{testCoverage-mask}
\title{Masking function}
\usage{
require(package, ...)

library(package, ...)

data(...)
}
\arguments{
  \item{...}{Parameters to pass onto the real function.}

  \item{package}{the name of a package, given as a
  \link{name} or literal character string, or a character
  string, depending on whether \code{character.only} is
  \code{FALSE} (default) or \code{TRUE}).}
}
\description{
Not intended for direct use. These functions complitments
the instrumentation process by intercepting calls to
functions of interest.
}
\keyword{internal}

