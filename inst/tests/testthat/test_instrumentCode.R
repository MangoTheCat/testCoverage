# Date of last change: 2014-12-16
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2013-2014
###############################################################################

context("instrument code")

###############################################################################

test_that("instrumentCodeFromFile", {
    
    # test 0
    
    expect_error(testCoverage:::instrumentCodeFromFile(), regexp = "is missing")
    
    # test 1
    
    testG <<- new.env()
    testG$idsSet <- NULL
    testG$verbose <- FALSE
    
    test01 <- testCoverage:::instrumentCodeFromFile(
        sourcefile = system.file(package = "testCoverage", 
            "examples", "add", "R", "add.R"), 
        fileid = 1L, envname = "testG", verbose = FALSE)
    
    expect_that(test01$idsSetHere, equals(c(29L, 32L)))
    
    expect_that(test01$gpd$text, equals(c("#' @param x", 
        "#' @param  y", "#' @title add", "#' @return function(x, y) { x + y }", 
        "#' @export", "", "add", "", "<-", "", "function", "(", "x", 
        ",", "y", ")", "", "{", "", "{`_trace`(c(1L, 29L)); x}", "", 
        "+", "{`_trace`(c(1L, 32L)); y}", "", "}")))
    
    testG$idsSet <- NULL
    
    # test 2
    
    test02 <- testCoverage:::instrumentCodeFromFile(
        sourcefile = system.file(package = "testCoverage", 
            "examples", "add", "R", "add.R"), 
        fileid = 1L, envname = "testG", ignorelist = "", verbose = FALSE)
    
    expect_that(test02$idsSetHere, equals(c(29L, 32L)))
    
    expect_that(test02$gpd$text, equals(c("#' @param x", 
        "#' @param  y", "#' @title add", "#' @return function(x, y) { x + y }", 
        "#' @export", "", "add", "", "<-", "", "function", "(", "x", 
        ",", "y", ")", "", "{", "", "{`_trace`(c(1L, 29L)); x}", "", 
        "+", "{`_trace`(c(1L, 32L)); y}", "", "}")))
    
    # test 3
    
    testG$idsSet <- NULL
    
    test03 <- testCoverage:::instrumentCodeFromFile(
        sourcefile = system.file(package = "testCoverage", 
            "examples", "fibonacci", "R", "fib.R"), 
        fileid = 1, envname = "testG", verbose = FALSE)
    
    expect_that(test03$idsSetHere, equals(c(27, 30, 43, 66, 
        69, 90, 93, 102, 124, 133, 156, 164, 178, 
        191, 203, 222, 225, 236, 239, 268, 271)))
    
    expect_that(test03$gpd$mask, equals(c(rep(FALSE, times = 5), TRUE, TRUE, TRUE, FALSE, 
            TRUE, TRUE, TRUE, TRUE, TRUE, rep(FALSE, times = 27), 
            TRUE, TRUE, TRUE, rep(FALSE, times = 54), TRUE, TRUE, TRUE, 
            rep(FALSE, times = 25), TRUE, TRUE, TRUE, TRUE, 
            rep(FALSE, times = 13), TRUE, 
            rep(FALSE, times = 3), TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, 
            rep(FALSE, times = 34))))
    
})
