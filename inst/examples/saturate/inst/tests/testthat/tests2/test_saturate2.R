# SVN revision:   
# Date of last change: 2013-11-27
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################

context("test outer function only")

test_that("hit some symbols", {
    
    eg <- c("hotpink", "orange", "#1100EE")
    
    out1 <- c("#FF0984", "#FFA500", "#1100EE")
    
    expect_that(saturate(eg, sat = 20), is_equivalent_to(out1))
    
    out2 <- c("#FFC6E3", "#FFA501", "#1201EE")
    
    expect_that(saturate(eg, sat = 0.2), is_equivalent_to(out2))

})
