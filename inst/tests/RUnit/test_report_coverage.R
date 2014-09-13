# SVN revision:   
# Date of last change: 2013-11-27
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################

  
test.pkg.add <- function() {
	rpt <- file.path(getwd(), "coverage_report_a0.html")
    out <- file.path(getwd(), "traceOutput_a0.txt")
	out_a0 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), "add", "R"),
		full.names = TRUE), executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), "add", "inst", "tests", "RUnit", "tests0"), full.names = TRUE), 
        reportfile = rpt, outputfile = out,
        ignorelist = "", writereport = getOption("testCoverageIsReport"), clean = TRUE,
		isrunit = TRUE, runitfileregexp = "^test_.+\\.[rR]$", runitfuncregexp = "^test.+")
	
	checkEquals(class(out_a0), "list")
	
	cat("\nTODO Fix reportCoverage! Function name not counted correctly\n")
	
	rpt <- file.path(getwd(), "coverage_report_a1.html")
	out <- file.path(getwd(), "traceOutput_a1.txt")
	
	out_a1 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), "add", "R"), full.names = TRUE),
			executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), "add", "inst", "tests", "RUnit", "tests1"), full.names = TRUE), 
			reportfile = rpt, outputfile = out,
			ignorelist = "", writereport = getOption("testCoverageIsReport"), clean = TRUE,
			isrunit = TRUE, runitfileregexp = "^test_.+\\.[rR]$", runitfuncregexp = "^test.+")
	
	checkEquals(class(out_a1), "list")
	checkEquals(out_a1$B[[1]]["Executed", "add.R"], 1)
}


test.pkg.fibonacci <- function() {
	rpt <- file.path(getwd(), "coverage_report_f0.html")
	out <- file.path(getwd(), "traceOutput_f0.txt")
	
	out_f0 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), "fibonacci", "R"), full.names = TRUE), 
			executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), "fibonacci", "inst", "tests", "RUnit", "tests0"), full.names = TRUE), 
			reportfile = rpt, outputfile = out,
			ignorelist = NULL, writereport = getOption("testCoverageIsReport"), clean = TRUE,
			isrunit = TRUE, runitfileregexp = "^test_.+\\.[rR]$", runitfuncregexp = "^test.+")
	
	checkEquals(class(out_f0), "list")
	#expect_that(out_f0, is_equivalent_to(cbind(19, 0, "  0%")))
	# TODO Fix
	
	rpt <- file.path(getwd(), "coverage_report_f1.html")
	out <- file.path(getwd(), "traceOutput_f1.txt")
	
	out_f1 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), "fibonacci", "R"), full.names = TRUE),
			executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), "fibonacci", "inst", "tests", "RUnit", "tests1"), full.names = TRUE), 
			reportfile = rpt, outputfile = out,
			ignorelist = NULL, writereport = getOption("testCoverageIsReport"), clean = TRUE,
			isrunit = TRUE, runitfileregexp = "^test_.+\\.[rR]$", runitfuncregexp = "^test.+")
	
	checkEquals(class(out_f1), "list")
	checkEquals(out_f1$B[[1]]["Executed", "fib.R"], 15)
	# TODO check and update
	
	rpt <- file.path(getwd(), "coverage_report_f2.html")
	out <- file.path(getwd(), "traceOutput_f2.txt")
	
	out_f2 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), "fibonacci", "R"), full.names = TRUE),
			executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), "fibonacci", "inst", "tests", "RUnit", "tests2"), full.names = TRUE), 
			reportfile = rpt, outputfile = out,
			ignorelist = NULL, writereport = getOption("testCoverageIsReport"), clean = TRUE,
			isrunit = TRUE, runitfileregexp = "^test_.+\\.[rR]$", runitfuncregexp = "^test.+")
	
	checkEquals(class(out_f2), "list")
	checkEquals(out_f2$B[[1]]["Executed", "fib.R"], 18)
}


test.pkg.saturate <- function() {
	rpt <- file.path(getwd(), "coverage_report_s0.html")
	out <- file.path(getwd(), "traceOutputs0.txt")
	
	out_s0 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), "saturate", "R"), full.names = TRUE),
			executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), "saturate", "inst", "tests", "RUnit", "tests0"), full.names = TRUE), 
			reportfile = rpt, outputfile = out,
			ignorelist = NULL, writereport = getOption("testCoverageIsReport"), clean = TRUE,
			isrunit = TRUE, runitfileregexp = "^test_.+\\.[rR]$", runitfuncregexp = "^test.+")
	
	checkEquals(class(out_s0), "list")
	checkEquals(out_s0$B[[1]]["Executed", "saturate.R"], 0)
	checkEquals(out_s0$B[[1]]["Executed", "saturateHSV.R"], 0)
	#expect_that(out_s0, is_equivalent_to(cbind(66, 0, "  0%")))
	# TODO Fix Me!
	cat("\nTODO Fix reportCoverage! Multi-file package not checked correctly\n")
	
	rpt <- file.path(getwd(), "coverage_report_s1.html")
	out <- file.path(getwd(), "traceOutputs1.txt")
	
	out_s1 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), "saturate", "R"), full.names = TRUE),
			executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), "saturate", "inst", "tests", "RUnit", "tests1"), full.names = TRUE), 
			reportfile = rpt, outputfile = out, writereport = getOption("testCoverageIsReport"), clean = TRUE,
			isrunit = TRUE, runitfileregexp = "^test_.+\\.[rR]$", runitfuncregexp = "^test.+")
	
	checkEquals(class(out_s1), "list")
	checkEquals(out_s1$B[[1]]["Executed", "saturate.R"], 0)
	checkEquals(out_s1$B[[1]]["Executed", "saturateHSV.R"], 16)
	#expect_that(out_s1, is_equivalent_to(cbind(66, 18, " 27%")))
	# TODO Fix and check
	
	rpt <- file.path(getwd(), "coverage_report_s2.html")
	out <- file.path(getwd(), "traceOutput_s2.txt")
	
	out_s2 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), "saturate", "R"), full.names = TRUE),
			executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), "saturate", "inst", "tests", "RUnit", "tests2"), full.names = TRUE), 
			reportfile = rpt, outputfile = out, writereport = getOption("testCoverageIsReport"), clean = TRUE,
			isrunit = TRUE, runitfileregexp = "^test_.+\\.[rR]$", runitfuncregexp = "^test.+")
	
	checkEquals(class(out_s2), "list")
	checkEquals(out_s2$B[[1]]["Executed", "saturate.R"], 12)
	checkEquals(out_s2$B[[1]]["Executed", "saturateHSV.R"], 16)
	#expect_that(out_s2, is_equivalent_to(cbind(66, 30, " 45%")))
	# TODO Fix and check
	
	rpt <- file.path(getwd(), "coverage_report_s3.html")
	out <- file.path(getwd(), "traceOutput_s3.txt")
	
	out_s3 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), "saturate", "R"), full.names = TRUE),
			executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), "saturate", "inst", "tests", "RUnit", "tests3"), full.names = TRUE), 
			reportfile = rpt, outputfile = out, writereport = getOption("testCoverageIsReport"), clean = TRUE,
			isrunit = TRUE, runitfileregexp = "^test_.+\\.[rR]$", runitfuncregexp = "^test.+")
	
	checkEquals(class(out_s3), "list")
	checkEquals(out_s3$B[[1]]["Executed", "saturate.R"], 13)
	checkEquals(out_s3$B[[1]]["Executed", "saturateHSV.R"], 23)
	checkEquals(out_s3$B[[2]]["Executed", "saturate.R"], 0)
	checkEquals(out_s3$B[[2]]["Executed", "saturateHSV.R"], 6)
	#expect_that(out_s3, is_equivalent_to(cbind(66, 66, "100%")))
	# TODO Fix and check
}






