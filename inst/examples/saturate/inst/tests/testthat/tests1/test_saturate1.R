# SVN revision:   
# Date of last change: 2013-11-27
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################

context("test inner function only")

test_that("hit some symbols", {
    
    eg <- matrix((1:9) * 16, nrow = 3)
    
    out1 <- matrix(
        c(  16, 189.107763615295, 48, 
            64, 229.859154929577, 96, 
            112, 242.947525120953, 144), 
        nrow = 3, ncol = 3)
    
    expect_that(saturateHSV(eg, sat = 20), is_equivalent_to(out1))
    
    out2 <- matrix(
        c(  16, 7.11421098517873, 48, 
            64, 21.3612565445026, 96, 
            112, 42.778505897772, 144), 
        nrow = 3, ncol = 3)
    
    expect_that(saturateHSV(eg, sat = 0.2), is_equivalent_to(out2))

})
