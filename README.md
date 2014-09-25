testCoverage
============

R Code Coverage Package


#Install
Installation from github requires the devtools package to be installed.
```
#Install devtools for devtools::install_github
install.packages("devtools")

# IF you are on Windows, you will also need the latest Rtools:
#install.packages('installr'); library('installr')
#installr::install.Rtools()


#Install a unit test framework
install.packages("testthat")

#Install testCoverage
devtools::install_github("MangoTheCat/testCoverage")
```

#Quick Start
Try out `cranCoverage`.

If a package tests features that require suggested packages they will need to be installed or misleading results will be produced.
```
#Load a unit testing framework and testCoverage.
library(testthat)
library(testCoverage)

#Install all dependencies of the test package.
#You may wish to use development mode to avoid polluting your library.
#devtools::dev_mode(on = TRUE)
install.packages("stringr", dependencies = TRUE)

#Run testCoverage.
cranCoverage("stringr")

```

#License
Clear BSD
