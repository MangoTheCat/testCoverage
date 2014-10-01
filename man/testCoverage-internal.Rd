\name{testCoverage-internal}
\alias{_trace}
\alias{testCoverage-internal}
\title{Internal function}
\usage{
"_trace"(idx = NULL, envname = ".g")
}
\arguments{
  \item{idx}{Identifier.}

  \item{envname}{single character (default '.g')
  environment to update}
}
\description{
Not intended for direct use. These functions are internal
to testCoverage's instrumentation process.

_trace expects an environment called .g to exist. The
function needs to be exported.
}
\keyword{internal}

