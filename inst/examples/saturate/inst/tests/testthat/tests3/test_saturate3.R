# SVN revision:   
# Date of last change: 2013-11-27
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################

context("test saturate")

test_that("hit some symbols", {
    
    eg <- c("hotpink", "orange", "#1100EE")
    
    out1 <- c("#FF0984", "#FFA500", "#1100EE")
    
    expect_that(saturate(eg, sat = 20), is_equivalent_to(out1))
    
    out2 <- c("#FFC6E3", "#FFA501", "#1201EE")
    
    expect_that(saturate(eg, sat = 0.2), is_equivalent_to(out2))

})

test_that("hit remaining symbols", {
    
    eg1 <- c("hotpink", "orange", "#1100EE")
    
    out1 <- c("#FF80BF", "#FFD280", "#7F77EE")
    
    expect_that(saturate(eg1, fix = 0.5), is_equivalent_to(out1))
    
    eg2 <- c("#FFC6E3", "a")
    
    expect_that(saturate(eg2, sat = 2), throws_error("invalid color name 'a'"))

    out3 <- c("#FFFFFF", "#FFFFFF", "#EEEEEE")
    
    expect_that(saturate(eg1, sat = -1), is_equivalent_to(out3))
})

