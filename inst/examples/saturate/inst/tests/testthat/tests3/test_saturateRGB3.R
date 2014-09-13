# SVN revision:   
# Date of last change: 2013-11-27
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################

context("test saturateRGB")

test_that("hit some symbols", {
    
    eg <- matrix((1:9) * 16, nrow = 3)
    
    out1 <- matrix(
        c(  16, 189.107763615295, 48, 
            64, 229.859154929577, 96, 
            112, 242.947525120953, 144), 
        nrow = 3, ncol = 3)
    
    expect_that(saturateHSV(eg, sat = 20), equals(out1))
    
    out2 <- matrix(
        c(  16, 7.11421098517873, 48, 
            64, 21.3612565445026, 96, 
            112, 42.778505897772, 144), 
        nrow = 3, ncol = 3)
    
    expect_that(saturateHSV(eg, sat = 0.2), equals(out2))
    
    expect_that(saturateHSV(eg), equals(eg))

})

test_that("hit remaining symbols", {
    
    eg1 <- matrix((1:6) * 32, nrow = 2, ncol = 3)
    
    expect_that(saturateHSV(eg1, fixed = 0.5), throws_error("three rows corresponding to hue, saturation and value expected in mat"))
    
    eg2 <- matrix(letters[1:6], nrow = 3, ncol = 2)
    
    expect_that(saturateHSV(eg2, sat = 2), throws_error("mat must be numeric"))
    
    eg3 <- matrix((1:6) * 32, nrow = 3, ncol = 2)
    
    expect_that(saturateHSV(eg3, sat = NA), throws_error("sat must be numeric"))
    
    expect_that(saturateHSV(eg3, fixed = NA), throws_error("fixed must be numeric"))
    
    out5 <- matrix(c(32, 0, 96, 128, 0, 192), nrow = 3)
    
    expect_that(saturateHSV(eg3, fixed = -1), equals(out5))
    
    out6 <- matrix(c(32, 255, 96, 128, 255, 192), nrow = 3)
    
    expect_that(saturateHSV(eg3, fixed = 2), equals(out6))
    
    eg7 <- matrix(c(123, -101, 55, 123, 101, 55, 123, 356, 55), nrow = 3, ncol = 3)
    
    out7 <- matrix(c(
            123, 0.509490509490509, 55, 
            123, 144.691011235955, 55, 
            123, 254.872436218109, 55), nrow = 3)
    
    expect_that(saturateHSV(eg7, sat = 2), equals(out7))
})
