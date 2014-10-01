testCoverage
============

Clear box unit test coverage utility for R code. 
A key concept of writing high quality code is that each conceptual module
of code is split into units. Each unit can be tested in isolation to verify that 
it is behaving as expected. A test means that inputs are provided to the 
code, and the outputs are checked against known results. These unit tests:
* provide documentation of a function's expected behaviour (very important 
when looking at someone else's code, or at your own code in 6 months!)
* allow changes to be made to other components of the code while demonstrably 
not affecting other units
* make it easier to check for bugs by providing a framework for passing in 
a range of inputs that other parts of your code, or your users, might provide

**Instrumentation**. The package replaces symbols in the code to be tested with a unique identifier.
This is then injected into a tracing function that will report each time 
the symbol is called. The first symbol at each level of the expression tree is 
traced, allowing the coverage of code branches to be checked. 

**Clear Box**. Once you have asked **testCoverage** run your tests, you will be provided with
and HTML report which allows you to see your code, with highlights to show whether
the the code is tested or not. This can also be broken down by test script 
while assessing which scripts need to be extended.

This package uses the alternate parser of R-3.0 to 
instrument R code, and record whether the code is run by tests. 

## Install
Installation from github requires the devtools package to be installed.

```R
# Install devtools for devtools::install_github
install.packages("devtools")

# Install a unit test framework
install.packages("testthat")

# Install testCoverage
devtools::install_github("MangoTheCat/testCoverage")
```

## Quick Start
Try out `cranCoverage`.

If a package tests features that require suggested packages they will need to be installed or misleading results will be produced.
```R
# Load a unit testing framework and testCoverage.
library(testthat)
library(testCoverage)

# Install all dependencies of the test package.
# You may wish to use development mode to avoid polluting your library.
# devtools::dev_mode(on = TRUE)
install.packages("stringr", dependencies = TRUE)

# Run testCoverage.
cranCoverage("stringr")
```

## Scripts 
```R
# example saturate 1 - partial coverage
reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), 
        "saturate", "R"), full.names = TRUE),
    executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), 
        "saturate", "inst", "tests", "testthat", "tests1"), full.names = TRUE), 
    reportfile = "testCoverage_saturate_example1.html", writereport = TRUE, clean = TRUE)

# example saturate 3 - complete coverage
reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), 
            "saturate", "R"), full.names = TRUE),
        executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), 
            "saturate", "inst", "tests", "testthat", "tests3"), full.names = TRUE), 
        reportfile = "testCoverage_saturate_example3.html", outputfile = out, writereport = TRUE, clean = TRUE)
```

## License
Clear BSD
