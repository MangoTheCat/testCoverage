# SVN revision:   
# Date of last change: 2014-06-04
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2013-2014
###############################################################################

context("html reporting utilities")

###############################################################################

test_that("makeDiv", {
    
    makeDiv <- testCoverage:::makeDiv
    # test 1

    test01 <- makeDiv()
    expect_that(test01, equals("<div>"))

    # test 2

    test02 <- makeDiv(id = 2)
    expect_that(test02, equals("<div id=\"2\">"))

    # test 3

    test03 <- makeDiv(open = FALSE, id = 3)
    expect_that(test03, equals("</div id=\"3\">"))
})


###############################################################################

test_that("makeTag", {
    
    makeTag = testCoverage:::makeTag
    # test 1

    test01 <- makeTag()
    expect_that(test01, equals("<span id=\"t\">"))

    # test 2

    test02 <- makeTag(id = 2, metastring = 3)
    expect_that(test02, equals("<span id=\"t_3_2\">"))

    # test 3

    test03 <- makeTag(open = FALSE, id = 3)
    expect_that(test03, equals("</span>"))
    
    # test 4

    test04 <- makeTag(id = 3)
    expect_that(test04, equals("<span id=\"t_3\">"))
    
    # test 5

    test05 <- makeTag(metastring = 1)
    expect_that(test05, equals("<span id=\"t_1\">"))
})



###############################################################################

test_that("addTags", {
    
    addTags = testCoverage:::addTags
    # test 1
    idt1 <- matrix("", nrow = 4, ncol = 5)
    gpdf1 <- data.frame(id = 1:9, 
        token = c(letters[1:4], "SYMBOL_FUNCTION_CALL", letters[1:4]), 
        c = 31:39, d = 41:49)

    test01 <- addTags(idtags = idt1, gpd = gpdf1, idtouse = 3)
    exp01 <- idt1
    exp01[3, 3] <- "<span id=\"t_3\">"
    expect_that(test01, equals(exp01))
})

