testCoverage
============

R Code Coverage Package


#Install
Installation from github requires the devtools package to be installed.
```
install.packages(c("devtools", "testthat"))
install_github("MangoTheCat/testCoverage")
```

#Quick Start
Try out `cranCoverage`. If a package tests features that require suggested packages they will need to be installed or misleading results will be produced.
```
library("testthat")
library(testCoverage)

cranCoverage("stringr")
```

#License
Clear BSD