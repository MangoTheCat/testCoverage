# SVN revision:   
# Date of last change: 2013-11-27
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################

context("miss testing add for two numbers")

test_that("non-traced function used", {
    
    expect_that(sum(1, 1), equals(2))
})
