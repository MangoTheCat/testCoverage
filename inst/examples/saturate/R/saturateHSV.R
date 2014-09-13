#' @title Adjust the saturation of a matrix of HSV colours
#' @param mat numeric matrix with three rows (hue, saturation and value) and one or more columns.
#'     Note that the second row must correspond to saturation.
#' @param sat single numeric factor by which to adjust saturation.
#' @param fixed single numeric fraction to which to set saturation for all col.
#' @return numeric matrix with three rows (hue, saturation and value).
#' @examples 
#'     eg <- matrix((1:9) * 16, nrow = 3)
#'     saturateHSV(eg, sat = 20)
#'     saturateHSV(eg, sat = 0.2)
#' @export

saturateHSV <-
function(mat, sat = 1, fixed = NULL) {
    
    if (!is.numeric(mat)) { stop("mat must be numeric") }
    
    if (nrow(mat) != 3) { stop("three rows corresponding to hue, saturation and value expected in mat") }
    
    if (!is.null(fixed)) {
        
        if (is.na(fixed) || !is.numeric(fixed)) { stop("fixed must be numeric") }
        
        fixed <- fixed * 255
        
        if (fixed < 0) { fixed <- 0 } 
        
        if (fixed > 255) { fixed <- 255 } 
        
        mat[2, ] <- fixed
        
    } else {
        
        if (is.na(sat) || !is.numeric(sat)) { stop("sat must be numeric") }
        
        satNums <- mat[2, ] / 255
        
        if (sat != 1) {
            
            satNums[satNums > 0.999] <- 0.999
            
            satNums[satNums < 0.001] <- 0.001
        }
        
        logits <- log(satNums / (1 - satNums)) + log(sat)
        
        mat[2, ] <- 255 / (1 + exp(-logits))
    }
    
    return(mat)
}
