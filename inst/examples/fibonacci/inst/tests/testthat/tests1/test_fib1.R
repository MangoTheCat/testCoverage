# SVN revision:   
# Date of last change: 2013-11-22
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################

context("calculate fibonacci numbers")

test_that("hit some symbols", {
    
    expect_that(fib(1), equals(1))
    
    expect_that(fib(2), equals(c(1, 1)))

    expect_that(fib(3), equals(c(1, 1, 2)))
    
    expect_that(fib(4), equals(c(1, 1, 2, 3)))
    
    expect_that(fib(5), equals(c(1, 1, 2, 3, 5)))
})
