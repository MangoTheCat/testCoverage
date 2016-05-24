#' @title Expected Sales
#' @description Expected Sales using linear extrapolation, 
#' tomorrow by default.
#' @param x SalesData object
#' @param when Date object specifying Date for which to extrapolate.
#' If missing, tomorrow's date will be used.
#' @return data frame with columns Date and Daily.Total
#' @examples
#' x <- new(Class = "SalesData", 
#'     Date = as.Date(x = 1:3, origin = "2015-12-18"),
#'     Daily.Total = 1:3,
#'     Outlet = "CHIPPENHAM")
#' expected(x)
#' @export

expected <- function(x, when) {
    if (!is(x, class2 = "SalesData")) { stop("x must be SalesData") }
    validObject(object = x)
    if (missing(when)) { when <- as.Date(Sys.time()) + 1 }
    if (!is(when, class2 = "Date")) { stop("when must be Date") }
    mod <- lm(Daily.Total ~ Date, data = as.data.frame(x))
    preds <- predict(object = mod, 
        newdata = data.frame(Date = when))
    return(data.frame(Date = when, Daily.Total = preds))
}
