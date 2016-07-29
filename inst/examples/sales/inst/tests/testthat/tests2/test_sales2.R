# Date of last change: 2016-07-29
# Last changed by: ccampbell
# Original author: ccampbell
# 
# Copyright Mango Solutions, Chippenham, UK 2016
# This document may be copied whole or in part for any use, 
# provided that this copyright notice is retained.
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
    
    expect_error(object = expected(x = women, when = as.Date("2015-12-22")), 
        regex = "x must be SalesData")
    
    expect_equal(object = class(expected(x = x)), expected = "data.frame")
    
    expect_error(object = expected(x = x, when = "2015-12-22"), 
        regex = "when must be Date")
    
})


test_that("hit symbols in as.data.frame and unique", {
    
    x <- new(Class = "SalesData", 
        Date = as.Date(x = 1:3, origin = "2015-12-18"),
        Daily.Total = 1:3,
        Outlet = "CHIPPENHAM")
    
    expect_equal(object = as.data.frame(x = x), 
        expected = data.frame(
            Date = as.Date(x = 1:3, origin = "2015-12-18"),
            Daily.Total = 1:3))
    
    expect_equal(object = unique(x = x), 
        expected = 1:3)
    
    expect_message(object = print(x), regex = "SalesData for")

})

