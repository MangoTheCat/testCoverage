# SVN revision:   
# Date of last change: 2013-11-27
# Last changed by: ccampbell
# 
# Original author: ccampbell
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################

test.saturate3 <- function() {
	eg <- c("hotpink", "orange", "#1100EE")
    
    out1 <- c("#FF0984", "#FFA500", "#1100EE")
    
	checkEquals(saturate(eg, sat = 20), out1)
    
    out2 <- c("#FFC6E3", "#FFA501", "#1201EE")
    
	checkEquals(saturate(eg, sat = 0.2), out2)
}

test.saturate3.remaining <- function() {
    eg1 <- c("hotpink", "orange", "#1100EE")
    
    out1 <- c("#FF80BF", "#FFD280", "#7F77EE")
    
	checkEquals(saturate(eg1, fix = 0.5), out1)
    
    eg2 <- c("#FFC6E3", "a")
    
	checkException(saturate(eg2, sat = 2))

    out3 <- c("#FFFFFF", "#FFFFFF", "#EEEEEE")
    
	checkEquals(saturate(eg1, sat = -1), out3)

}



