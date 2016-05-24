# Date of last change: 2016-01-08
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2016
###############################################################################

context("test expected")

test_that("hit symbols in expected", {
    
    x <- new(Class = "SalesData", 
        Date = as.Date(x = 1:3, origin = "2015-12-18"),
        Daily.Total = 1:3,
        Outlet = "CHIPPENHAM")
    
    expect_equal(object = expected(x = x, when = as.Date("2015-12-22")), 
        expected = structure(
            list(
                Date = structure(16791, class = "Date"), 
                Daily.Total = 4), 
            .Names = c("Date", "Daily.Total"), 
            row.names = "1", 
            class = "data.frame"))

})


test_that("validation", {
    
    x <- data.frame(Date = as.Date(x = 1:3, origin = "2015-12-18"),
        Daily.Total = 1:3,
        Outlet = "CHIPPENHAM")
    
    expect_error(object = expected(x = x, when = as.Date("2015-12-22")), 
        regexp = "x must be SalesData")

})
