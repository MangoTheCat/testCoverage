# SVN revision:   
# Date of last change: 2013-11-22
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################

test.fib1 <- function() {
	checkEquals(fib(1), 1)
	
	checkEquals(fib(2), c(1, 1))
	
	checkEquals(fib(3), c(1, 1, 2))
	
	checkEquals(fib(4), c(1, 1, 2, 3))
	
	checkEquals(fib(5), c(1, 1, 2, 3, 5))
}

