# Date of last change: 2015-01-29
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2013-2015
###############################################################################

context("increment with left to right assignment")

test_that("one can be added to x", {
    
    expect_that(incr(x = -3:-1), equals(-2:0))
})

# quit
q("no")
