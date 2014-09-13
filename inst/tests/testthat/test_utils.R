# SVN revision:   $
# Date of last change: 2013-09-21 $
# Last changed by: $LastChangedBy: ccampbell $
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################

context("other utilities")

###############################################################################

test_that("fcat", {
    
    # test 1

    testCoverage:::fcat("test01", file = "delete_me", verbose = TRUE)

    test01 <- scan(file = "delete_me", what = "character", quiet = TRUE)
    
    expect_that(test01, is_identical_to("test01"))
    
    unlink("delete_me")
    
    # test 2

    testCoverage:::fcat("test02", file = "intentionally_missing", verbose = FALSE)

    expect_that(scan(file = "intentionally_missing", what = "character", quiet = TRUE), throws_error("cannot open the connection"))
    
})


###############################################################################

test_that("is.assign", {
    
    # test 1

    test01 <- testCoverage:::is.assign(as.symbol('<-'))
    expect_true(test01)

    # test 2

    test02 <- !testCoverage:::is.assign(as.symbol('=='))
    expect_true(test02)

})

