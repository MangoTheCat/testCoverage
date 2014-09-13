library(testCoverage)

if(!require(RUnit)) stop("RUnit must be installed.")
if(!require(testthat)) stop("testthat must be installed.")

message("Reporting RUnit test coverage for package saturate...")
out_RUnit <- reportCoverage(
		sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), 
                                       "saturate", "R"), full.names = TRUE),
		executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), 
                                          "saturate", "inst", "tests", "RUnit", 
                                          "tests2"), full.names = TRUE),  
		reportfile = tempfile(fileext = ".html"), 
    outputfile = tempfile(fileext = ".txt"),
		ignorelist = NULL, writereport = TRUE, clean = TRUE, isrunit = TRUE, 
    runitfileregexp = "^test_.+\\.[rR]$", runitfuncregexp = "^test.+")

message("Reporting testthat test coverage for package saturate...")
out_testthat <- reportCoverage(
  sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), 
                                     "saturate", "R"), full.names = TRUE),
  executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), 
                                        "saturate", "inst", "tests", "testthat", 
                                        "tests2"), full.names = TRUE),
  reportfile = tempfile(fileext = ".html"), 
  outputfile = tempfile(fileext = ".txt"),
  writereport = TRUE, clean = TRUE)
