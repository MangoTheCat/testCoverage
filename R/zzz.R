# SVN revision:   $
# Date of last change: 2013-12-11 $
# Last changed by: $LastChangedBy: ccampbell $
# 
# Original author: jjxie
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################

.onAttach <- function(libname, pkgname){
  options(testCoverageIsReport = FALSE)
  options(testCoverageExpFolder = system.file(package = "testCoverage", "examples"))
  packageStartupMessage(paste("Loading package testCoverage\n", 
    "Developed by Mango Solutions <support@mango-solutions.com>.\n", 
    "\n",
    "It it recomended to restart R after using testCoverage.", 
    "Either testthat or RUnit must be loaded."))
}