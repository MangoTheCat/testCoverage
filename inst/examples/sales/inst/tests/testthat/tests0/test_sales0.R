# Date of last change: 2016-01-08
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2016
###############################################################################

context("miss testing sales")

test_that("non-traced function used", {
    
    mod <- lm(Daily.Total ~ Date, 
        data = data.frame(Daily.Total = 1:3, 
            Date = as.Date(x = 1:3, origin = "2015-12-18")))
    preds <- predict(object = mod, 
        newdata = data.frame(Date = as.Date(x = 5, origin = "2015-12-18")))
    
    expect_equal(unname(preds), 5)
})
