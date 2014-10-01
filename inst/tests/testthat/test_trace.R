# SVN revision:   
# Date of last change: 2014-08-01
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################

context("tracing utilities")

###############################################################################

test_that("getAtPos", {

    # test 1    
    expr <- expression(`_1_16`  <-
        function ( x , y )  {  `_1_29`  + `_1_32`  })

    expect_that(testCoverage:::getAtPos(e = expr, pos = integer(0)), is_identical_to(expr))
    
    # test 2
    expect_that(testCoverage:::getAtPos(e = expr, pos = 1), is_identical_to(expr[[1]]))
    
    # test 3
    expect_that(deparse(testCoverage:::getAtPos(e = expr, pos = c(1, 1))), is_identical_to("<-"))
    
    # test 4 
    expr <- expression({
        `_trace`(c(1L, 16L))
        add <- {
            `_trace`()
            function(x, y) {
                `_trace`()
                {
                    {
                      `_trace`()
                      `_1_29` + `_1_32`
                    }
                } 
            }    
        }          
    })
    
    expect_that(names(testCoverage:::getAtPos(e = expr, pos = c(1, 3, 3, 3, 2))), is_identical_to(c("x", "y")))
    
    # test 5
    expect_that(deparse(testCoverage:::getAtPos(e = expr, pos = c(1, 3, 3, 3, 3, 3, 2, 2))), is_identical_to("`_trace`()"))
    
    # test 6
    expect_that(deparse(testCoverage:::getAtPos(e = expr, pos = c(1, 3, 3, 3, 3, 3, 2, 3))), is_identical_to("`_1_29` + `_1_32`"))
    
    # test 7
    expect_that(deparse(testCoverage:::getAtPos(e = expr, pos = c(1, 3, 3, 3, 2, 2))), is_identical_to(""))
    
})


###############################################################################

test_that("createTracedExpression", {

    # test 1
    
    testG <- new.env()
    testG$verbose <- FALSE
    testG$ignorelist <- ""
    testG$replText <- ""
    testG$idsSet <- cbind(1, 29)

    
    test01 <- testCoverage:::createTracedExpression(
        sourcefile = file.path(system.file(package = "testCoverage"), "examples", "add", "R", "add.R"), 
        fileid = 1, envname = "testG")
    
    traced <-  c("expression({",                                               
        "    `_trace`()",
        "    `_1_16` <- {",
        "        `_trace`()",
        "        function(x, y) {",
        "            `_trace`()",
        "            {",
        "                {",
        "                  `_trace`()",
        "                  `_1_29` + `_1_32`",
        "                }",
        "            }",
        "        }",
        "    }",
        "})")
        
    expect_that(names(test01), equals(c("symbolExpression", "tracedExpression", "parsedData")))
    
    test01_se <- deparse(c(test01$symbolExpression))
    
    expect_that(test01_se, equals(traced))

})


test_that("recurseInsertTrace", {
    
    # test 1
    
    expr <- expression(`_1_16`  <-
        function ( x , y )  {  `_1_29`  + `_1_32`  })

    testG <<- new.env()
    testG$verbose <- TRUE
    testG$ignorelist <- ""
    testG$ignorelistRepl <- ""
    debug(testCoverage:::recurseInsertTrace)
    test01 <- testCoverage:::recurseInsertTrace(e = expr, envname = 'testG', pos = integer(0), addtrace = TRUE)
    undebug(testCoverage:::recurseInsertTrace)
    traced <-  c("expression({",                                               
        "    `_trace`()",
        "    `_1_16` <- {",
        "        `_trace`()",
        "        function(x, y) {",
        "            `_trace`()",
        "            {",
        "                {",
        "                  `_trace`()",
        "                  `_1_29` + `_1_32`",
        "                }",
        "            }",
        "        }",
        "    }",
        "})")
    
    expect_that(deparse(test01), equals(traced))
    
})


