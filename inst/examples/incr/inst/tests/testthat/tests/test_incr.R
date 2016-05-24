# Date of last change: 2015-01-30
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2013-2014
###############################################################################

context("reverse assign must be ignored")

test_that("one can be added to x", {
    
    expect_that(incr(x = 1), equals(2))
})
