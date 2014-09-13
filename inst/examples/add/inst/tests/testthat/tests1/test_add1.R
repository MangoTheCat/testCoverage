# SVN revision:   
# Date of last change: 2013-11-22
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################

context("adding two numbers")

test_that("two length one vectors can be added together", {
    
    expect_that(add(1, 1), equals(2))
})
