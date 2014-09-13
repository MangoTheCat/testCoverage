# SVN revision:   
# Date of last change: 2013-11-27
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################

context("miss testing fib")

test_that("non-traced function used", {
    
    expect_that(rep(1, 2), equals(c(1, 1)))
})
