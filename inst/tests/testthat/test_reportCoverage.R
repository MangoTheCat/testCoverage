
# Date of last change: 2014-10-01
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2013-2014
###############################################################################

# counting symbol hits
cat(" --- add example ---\n")

test_that("add", {
    
    # replacing 3 symbols... add, x, y - one function name + 2 internal symbols
    # setting 2 trace points... add, x 
    # one instrumented trace point is added at each level of the parse tree
    
    # zero tests for instrumented functions
    
    rpt <- file.path(getwd(), "coverage_report_a0.html")
    out <- file.path(getwd(), "traceOutput_a0.txt")
    
    out_a0 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), 
            "add", "R"), full.names = TRUE), 
        executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), 
                "add", "inst", "tests", "testthat", "tests0"), full.names = TRUE), 
        reportfile = rpt, outputfile = out,
        ignorelist = "", writereport = getOption("testCoverageIsReport"), 
        clean = TRUE, verbose = FALSE)
    
    a0ex <- structure(list(
            A = structure(c(1L, 0L), 
                .Dim = c(2L, 1L), 
                .Dimnames = list(c("Trace Points", "test_add0.R"), "add.R")), 
            E = FALSE, 
            B = structure(list(
                test_add0.R = structure(0:1, 
                    .Dim = c(2L, 1L), 
                    .Dimnames = structure(list(c("Executed", "Not Executed"), "add.R"), 
                    .Names = c("", "")), class = "table")), .Names = "test_add0.R")), 
        .Names = c("A", "E", "B"))
    
    expect_that(out_a0, equals(a0ex))
    
    # tests for instrumented functions
    
    rpt <- file.path(getwd(), "coverage_report_a1.html")
    out <- file.path(getwd(), "traceOutput_a1.txt")
    
    out_a1 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), 
            "add", "R"), full.names = TRUE),
        executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), 
            "add", "inst", "tests", "testthat", "tests1"), full.names = TRUE), 
        reportfile = rpt, outputfile = out,
        ignorelist = "", writereport = getOption("testCoverageIsReport"), 
        clean = TRUE, verbose = FALSE)
    
    a1ex <- structure(list(
            A = structure(c(1L, 1L), 
                .Dim = c(2L, 1L), 
                .Dimnames = list(c("Trace Points", "test_add1.R"), "add.R")), 
            E = FALSE, 
            B = structure(list(
                test_add0.R = structure(1:0, 
                    .Dim = c(2L, 1L), 
                    .Dimnames = structure(list(c("Executed", "Not Executed"), "add.R"), 
                    .Names = c("", "")), class = "table")), .Names = "test_add1.R")), 
        .Names = c("A", "E", "B"))
    
    expect_that(out_a1, equals(a1ex))
    
})

cat("\n --- fibonacci example ---")

test_that("fibonacci", {
    
    # zero tests for instrumented functions
    
    rpt <- file.path(getwd(), "coverage_report_f0.html")
    out <- file.path(getwd(), "traceOutput_f0.txt")
    
    out_f0 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), 
            "fibonacci", "R"), full.names = TRUE), 
        executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), 
            "fibonacci", "inst", "tests", "testthat", "tests0"), full.names = TRUE), 
        reportfile = rpt, outputfile = out,
        ignorelist = NULL, writereport = getOption("testCoverageIsReport"), 
        clean = TRUE, verbose = FALSE)
    
    f0ex <- structure(list(
            A = structure(c(18L, 0L), 
                .Dim = c(2L, 1L), 
                .Dimnames = list(c("Trace Points", "test_fib0.R"), "fib.R")), 
            E = FALSE, 
            B = structure(list(
                test_fib0.R = structure(c(0L, 18L), 
                    .Dim = c(2L, 1L), 
                    .Dimnames = structure(list(c("Executed", "Not Executed"), "fib.R"), 
                    .Names = c("", "")), class = "table")), .Names = "test_fib0.R")), 
        .Names = c("A", "E", "B"))
    
    expect_that(out_f0, equals(f0ex))
    
    # tests for instrumented functions
    
    rpt <- file.path(getwd(), "coverage_report_f1.html")
    
    out_f1 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), 
            "fibonacci", "R"), full.names = TRUE),
        executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), 
            "fibonacci", "inst", "tests", "testthat", "tests1"), full.names = TRUE), 
        reportfile = rpt, outputfile = out,
        ignorelist = NULL, writereport = getOption("testCoverageIsReport"), 
        clean = TRUE, verbose = FALSE)
    
    f1ex <- structure(list(
            A = structure(c(18L, 15L), 
                .Dim = c(2L, 1L), 
                .Dimnames = list(c("Trace Points", "test_fib1.R"), "fib.R")), 
            E = FALSE, 
            B = structure(list(
                test_fib1.R = structure(c(15L, 3L), 
                    .Dim = c(2L, 1L), 
                    .Dimnames = structure(list(c("Executed", "Not Executed"), "fib.R"), 
                    .Names = c("", "")), class = "table")), .Names = "test_fib1.R")), 
        .Names = c("A", "E", "B"))
    
    expect_that(out_f1, equals(f1ex))
    
    # tests 100% tracepoints for instrumented functions
    
    rpt <- file.path(getwd(), "coverage_report_f2.html")
    out <- file.path(getwd(), "traceOutput_f2.txt")
    
    out_f2 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), 
            "fibonacci", "R"), full.names = TRUE),
        executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), 
            "fibonacci", "inst", "tests", "testthat", "tests2"), full.names = TRUE), 
        reportfile = rpt, outputfile = out,
        ignorelist = NULL, writereport = getOption("testCoverageIsReport"), 
        clean = TRUE, verbose = FALSE)
    
    f2ex <- structure(list(
            A = structure(c(18L, 18L), 
                .Dim = c(2L, 1L), 
                .Dimnames = list(c("Trace Points", "test_fib2.R"), "fib.R")), 
            E = FALSE, 
            B = structure(list(
                test_fib0.R = structure(c(18L, 0L), 
                    .Dim = c(2L, 1L), 
                    .Dimnames = structure(list(c("Executed", "Not Executed"), "fib.R"), 
                    .Names = c("", "")), class = "table")), .Names = "test_fib2.R")), 
        .Names = c("A", "E", "B"))
    
    expect_that(out_f2, equals(f2ex))
    
})

cat("\n --- saturate example ---")

test_that("saturate", {
    
    # zero tests for instrumented functions
    
    rpt <- file.path(getwd(), "coverage_report_s0.html")
    out <- file.path(getwd(), "traceOutputs0.txt")
    
    out_s0 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), 
            "saturate", "R"), full.names = TRUE),
        executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), 
            "saturate", "inst", "tests", "testthat", "tests0"), full.names = TRUE), 
        reportfile = rpt, outputfile = out,
        ignorelist = NULL, writereport = getOption("testCoverageIsReport"), 
        clean = TRUE, verbose = FALSE)
    
    s0ex <- structure(list(
            A = structure(c(13L, 0L, 29L, 0L), 
                .Dim = c(2L, 2L), 
                .Dimnames = list(c("Trace Points", "test_saturate0.R"), c("saturate.R", "saturateHSV.R"))), 
            E = FALSE, 
            B = structure(list(
                test_saturate0.R = structure(c(0L, 13L, 0L, 29L), 
                    .Dim = c(2L, 2L), 
                    .Dimnames = structure(list(c("Executed", "Not Executed"), c("saturate.R", "saturateHSV.R")), 
                    .Names = c("", "")), class = "table")), .Names = "test_saturate0.R")), 
        .Names = c("A", "E", "B"))
    
    expect_that(out_s0, equals(s0ex))
    
    # tests for instrumented functions
    
    rpt <- file.path(getwd(), "coverage_report_s1.html")
    out <- file.path(getwd(), "traceOutputs1.txt")
    
    out_s1 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), 
            "saturate", "R"), full.names = TRUE),
        executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), 
            "saturate", "inst", "tests", "testthat", "tests1"), full.names = TRUE), 
        reportfile = rpt, outputfile = out, writereport = getOption("testCoverageIsReport"), 
        clean = TRUE, verbose = FALSE)
    
    s1ex <- structure(list(
            A = structure(c(13L, 0L, 29L, 16L), 
                .Dim = c(2L, 2L), 
                .Dimnames = list(c("Trace Points", "test_saturate1.R"), c("saturate.R", "saturateHSV.R"))), 
            E = FALSE, 
            B = structure(list(
                test_saturate0.R = structure(c(0L, 13L, 16L, 13L), 
                    .Dim = c(2L, 2L), 
                    .Dimnames = structure(list(c("Executed", "Not Executed"), c("saturate.R", "saturateHSV.R")), 
                    .Names = c("", "")), class = "table")), .Names = "test_saturate1.R")), 
        .Names = c("A", "E", "B"))
    
    expect_that(out_s1, equals(s1ex))
    
    # tests for instrumented functions
    
    rpt <- file.path(getwd(), "coverage_report_s2.html")
    out <- file.path(getwd(), "traceOutput_s2.txt")
    
    out_s2 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), 
            "saturate", "R"), full.names = TRUE),
        executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), 
            "saturate", "inst", "tests", "testthat", "tests2"), full.names = TRUE), 
        reportfile = rpt, outputfile = out, writereport = getOption("testCoverageIsReport"), 
        clean = TRUE, verbose = FALSE)
    
    s2ex <- structure(list(
            A = structure(c(13L, 12L, 29L, 16L), 
                .Dim = c(2L, 2L), 
                .Dimnames = list(c("Trace Points", "test_saturate2.R"), c("saturate.R", "saturateHSV.R"))), 
            E = FALSE, 
            B = structure(list(
                test_saturate0.R = structure(c(12L, 1L, 16L, 13L), 
                    .Dim = c(2L, 2L), 
                    .Dimnames = structure(list(c("Executed", "Not Executed"), c("saturate.R", "saturateHSV.R")), 
                    .Names = c("", "")), class = "table")), .Names = "test_saturate2.R")), 
        .Names = c("A", "E", "B"))
    
    expect_that(out_s2, equals(s2ex))
    
    # tests for instrumented functions
    
    rpt <- file.path(getwd(), "coverage_report_s3.html")
    out <- file.path(getwd(), "traceOutput_s3.txt")
    
    out_s3 <- reportCoverage(sourcefiles = list.files(file.path(getOption("testCoverageExpFolder"), 
            "saturate", "R"), full.names = TRUE),
        executionfiles = list.files(file.path(getOption("testCoverageExpFolder"), 
            "saturate", "inst", "tests", "testthat", "tests3"), full.names = TRUE), 
        reportfile = rpt, outputfile = out, writereport = getOption("testCoverageIsReport"), 
        clean = TRUE, verbose = FALSE)
    
    s3ex <- structure(list(
            A = structure(c(13L, 13L, 0L, 29L, 23L, 6L), 
                .Dim = c(3L, 2L), 
                .Dimnames = list(c("Trace Points", "test_saturate3.R", "test_saturateRGB3.R"), 
                    c("saturate.R", "saturateHSV.R"))), 
            E = c(FALSE, FALSE), 
            B = structure(list(
                test_saturate3.R = structure(c(13L, 0L, 23L, 6L), 
                    .Dim = c(2L, 2L), 
                    .Dimnames = structure(list(c("Executed", "Not Executed"), c("saturate.R", "saturateHSV.R")), 
                    .Names = c("", "")), class = "table"), 
                test_saturateRGB3.R = structure(c(0L, 13L, 6L, 23L), 
                    .Dim = c(2L, 2L), 
                    .Dimnames = structure(list(c("Executed", "Not Executed"), c("saturate.R", "saturateHSV.R")), 
                    .Names = c("", "")), class = "table")), 
                .Names = c("test_saturate3.R", "test_saturateRGB3.R"))), 
            .Names = c("A", "E", "B"))
    
    expect_that(out_s3, equals(s3ex))
})

cat("\n --- testCoverage utilities ---")

context("check invalid package structure throws error")

test_that("add", {

    expect_that(reportCoverage("add", rdir = file.path("inst", "examples", "add")), 
        throws_error("no source files selected"))
})
