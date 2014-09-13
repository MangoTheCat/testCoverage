# SVN revision:   
# Date of last change: 2013-11-22
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################

test.fib2 <- function() {
	checkEquals(fib(1), 1)
	
	checkEquals(fib(2), c(1, 1))
	
	checkEquals(fib(3), c(1, 1, 2))
	
	checkEquals(fib(4), c(1, 1, 2, 3))
	
	checkEquals(fib(5), c(1, 1, 2, 3, 5))
}

test.fib2.error <- function() {
	checkException(fib("a"), silent = TRUE)
	
	checkException(fib(), silent = TRUE)
	
	checkException(fib(0), silent = TRUE)
	
	checkException(fib(Inf), silent = TRUE)
	
	checkException(fib(1:3), silent = TRUE)
	
}

