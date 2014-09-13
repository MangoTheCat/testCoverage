# SVN revision:   
# Date of last change: 2014-7-31
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################

  
context("counting symbol hits")

test_that("add", {
    
    rpt <- file.path(getwd(), "coverage_report_a0.html")
    out <- file.path(getwd(), "traceOutput_a0.txt")
    
    out_a0 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), "add", "R"), full.names = TRUE), 
        executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), "add", "inst", "tests", "testthat", "tests0"), full.names = TRUE), 
        reportfile = rpt, outputfile = out,
        ignorelist = "", writereport = getOption("testCoverageIsReport"), clean = TRUE)
        
    a0ex <- structure(list(
            A = structure(c(1L, 0L), 
                .Dim = c(2L, 1L), 
                .Dimnames = list(c("Trace Points", "test_add0.R"), "add.R")), 
            E = FALSE, 
            B = structure(list(
                test_add0.R = structure(0:1, .Dim = c(2L, 1L), .Dimnames = structure(list(c("Executed", "Not Executed"), "add.R"), 
                .Names = c("", "")), class = "table")), .Names = "test_add0.R")), 
            .Names = c("A", "E", "B"))
    
    expect_that(out_a0, equals(a0ex))
    
    
    cat("\nTODO Fix reportCoverage! Function symbols not counted correctly\n")
    # curious behaviour
    #  1 add.R ... 
    # replacing 3 symbols... add, x, y - one function name + 2 internal symbols
    # adding 4 original trace points... add, function, x, y
    # setting 2 trace points... add, x - why is y missed?
    
    rpt <- file.path(getwd(), "coverage_report_a1.html")
    out <- file.path(getwd(), "traceOutput_a1.txt")
    
    out_a1 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), "add", "R"), full.names = TRUE),
        executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), "add", "inst", "tests", "testthat", "tests1"), full.names = TRUE), 
        reportfile = rpt, outputfile = out,
        ignorelist = "", writereport = getOption("testCoverageIsReport"), clean = TRUE)
    
    expect_that(out_a1$B, is_a("list"))
    #expect_that(out_a1, is_equivalent_to(cbind(1, 1, "100%")))
    # or should this be cbind(3, 0, "0%")
    # one function name + 2 internal symbols
    # Now this is currently
    #[[1]]
    #              
    #               add.R
    #  Executed         1
    #  Not Executed     0

    
})

test_that("fibonacci", {
    
    rpt <- file.path(getwd(), "coverage_report_f0.html")
    out <- file.path(getwd(), "traceOutput_f0.txt")
    
    out_f0 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), "fibonacci", "R"), full.names = TRUE), 
        executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), "fibonacci", "inst", "tests", "testthat", "tests0"), full.names = TRUE), 
        reportfile = rpt, outputfile = out,
        ignorelist = NULL, writereport = getOption("testCoverageIsReport"), clean = TRUE)
    
    expect_that(out_f0$B, is_a("list"))
    #expect_that(out_f0, is_equivalent_to(cbind(19, 0, "  0%")))
    # TODO Fix
    
    rpt <- file.path(getwd(), "coverage_report_f1.html")
    out <- file.path(getwd(), "traceOutput_f1.txt")
    
    out_f1 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), "fibonacci", "R"), full.names = TRUE),
        executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), "fibonacci", "inst", "tests", "testthat", "tests1"), full.names = TRUE), 
        reportfile = rpt, outputfile = out,
        ignorelist = NULL, writereport = getOption("testCoverageIsReport"), clean = TRUE)
    
    expect_that(out_f1$B, is_a("list"))
    expect_that(out_f1$B, equals(structure(list(test_fib1.R = structure(c(15L, 
    3L), .Dim = c(2L, 1L), .Dimnames = structure(list(c("Executed", 
    "Not Executed"), "fib.R"), .Names = c("", "")), class = "table")), .Names = "test_fib1.R")))

    # TODO check and update
    
    rpt <- file.path(getwd(), "coverage_report_f2.html")
    out <- file.path(getwd(), "traceOutput_f2.txt")
    
    out_f2 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), "fibonacci", "R"), full.names = TRUE),
        executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), "fibonacci", "inst", "tests", "testthat", "tests2"), full.names = TRUE), 
        reportfile = rpt, outputfile = out,
        ignorelist = NULL, writereport = getOption("testCoverageIsReport"), clean = TRUE)
    
    expect_that(out_f2$B, is_a("list"))
    expect_that(out_f2$A, equals(structure(c(18L, 18L), .Dim = c(2L, 
    1L), .Dimnames = list(c("Trace Points", "test_fib2.R"), "fib.R"))))
})


test_that("saturate", {
    
    rpt <- file.path(getwd(), "coverage_report_s0.html")
    out <- file.path(getwd(), "traceOutputs0.txt")
    
    out_s0 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), "saturate", "R"), full.names = TRUE),
        executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), "saturate", "inst", "tests", "testthat", "tests0"), full.names = TRUE), 
        reportfile = rpt, outputfile = out,
        ignorelist = NULL, writereport = getOption("testCoverageIsReport"), clean = TRUE)
    
    expect_that(out_s0$B, is_a("list"))
    #expect_that(out_s0, is_equivalent_to(cbind(66, 0, "  0%")))
    # TODO Fix Me!
    cat("\nTODO Fix reportCoverage! Multi-file package not checked correctly\n")
    
    rpt <- file.path(getwd(), "coverage_report_s1.html")
    out <- file.path(getwd(), "traceOutputs1.txt")
    
    out_s1 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), "saturate", "R"), full.names = TRUE),
        executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), "saturate", "inst", "tests", "testthat", "tests1"), full.names = TRUE), 
        reportfile = rpt, outputfile = out, writereport = getOption("testCoverageIsReport"), clean = TRUE)
    
    expect_that(out_s1$B, is_a("list"))
    #expect_that(out_s1, is_equivalent_to(cbind(66, 18, " 27%")))
    # TODO Fix and check
    
    rpt <- file.path(getwd(), "coverage_report_s2.html")
    out <- file.path(getwd(), "traceOutput_s2.txt")
    
    out_s2 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), "saturate", "R"), full.names = TRUE),
        executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), "saturate", "inst", "tests", "testthat", "tests2"), full.names = TRUE), 
        reportfile = rpt, outputfile = out, writereport = getOption("testCoverageIsReport"), clean = TRUE)
    
    expect_that(out_s2$B, is_a("list"))
    #expect_that(out_s2, is_equivalent_to(cbind(66, 30, " 45%")))
    # TODO Fix and check
    
    rpt <- file.path(getwd(), "coverage_report_s3.html")
    out <- file.path(getwd(), "traceOutput_s3.txt")
    
    out_s3 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), "saturate", "R"), full.names = TRUE),
        executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), "saturate", "inst", "tests", "testthat", "tests3"), full.names = TRUE), 
        reportfile = rpt, outputfile = out, writereport = getOption("testCoverageIsReport"), clean = TRUE)
    
    expect_that(out_s3$B, is_a("list"))
    #expect_that(out_s3, is_equivalent_to(cbind(66, 66, "100%")))
    # TODO Fix and check
})


context("check invalid package structure throws error")

test_that("add", {

    expect_that(reportCoverage("add", rdir = file.path("inst", "examples", "add")), throws_error("no source files selected"))
})
