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

test_that("hit error checking symbols", {
    
    expect_that(fib("a"), throws_error("n not recognized"))
    
    expect_that(fib(), throws_error("'n' is missing"))

    expect_that(fib(0), throws_error("n should be an integer greater than 0"))
    
    expect_that(fib(Inf), throws_error("n not recognized"))
    
    expect_that(fib(1:3), throws_error("n must be length 1"))
})
