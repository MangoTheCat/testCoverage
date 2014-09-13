#' @title Adjust the saturation of a colour
#' @param col character matrix with colour names or hexadecimal values
#' @param sat single numeric factor by which to adjust saturation
#' @param fixed single numeric fraction to which to set saturation for all col
#' @return numeric matrix with three rows (red, green and blue)
#' @examples 
#'     eg <- c("hotpink", "cornflowerblue", "#1100EE")
#'     saturate(eg, sat = 20)
#'     saturate(eg, sat = 0.2)
#' @export

saturate <-
function(col, sat = 1, fixed = NULL) {
    
    rgbNums <- col2rgb(col)
    
    hsvNums <- rgb2hsv(rgbNums) * 255
    
    if (sat <= 0) { fixed <- 0 }
    
    hsvNums <- saturateHSV(mat = hsvNums, sat = sat, fixed = fixed) / 255
    
    rgbOut <- do.call("hsv", as.data.frame(t(hsvNums)))
    
    return(rgbOut)
}
