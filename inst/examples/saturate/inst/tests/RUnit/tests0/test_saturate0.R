# SVN revision:   
# Date of last change: 2013-11-27
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################

test.saturate0 <- function() {
	eg <- c("hotpink", "orange", "#1100EE")
    out <- matrix(c(255, 105, 180, 255, 165, 0, 17, 0, 238), nrow = 3)
    rownames(out) <- c("red", "green", "blue")
	checkEquals(col2rgb(eg), out)
}

