# original author: ccampbell
# last change by: ccampbell
# last change date: 08-Jan-2016

# check SalesData validity
# 
# @param object SalesData object
# @return TRUE or error

validSalesData <- function(object) {
    dates <- slot(object = object, name = "Date")
    if (any(dates < as.Date("2015-04-05"))) { 
        stop("Dates out of range") }
    len <- length(dates)
    if (length(slot(object = object,
            name = "Daily.Total")) != len) {
        stop("Expected equal number of Daily.Total and Date") }
    outlet <- slot(object = object, name = "Outlet")
    if (length(outlet) != 1) {
        stop("Expected single Outlet") }
    if (!outlet %in% c("CHIPPENHAM", "SHANGHAI")) {
        stop("Invalid Outlet") }
    return(TRUE)
}


#' An S4 class to represent Sales Data.
#'
#' An object with three slots.
#' 
#' @slot Date Date vector
#' @slot Daily.Total numeric value of sales of length Date
#' @slot Outlet single character name of outlet (e.g. "CHIPPENHAM")
#' @name SalesData-class
#' @rdname SalesData-class
#' @exportClass SalesData
#' @aliases SalesData
#' @examples
#' x <- new(Class = "SalesData", 
#'     Date = as.Date(x = 1:3, origin = "2015-12-18"),
#'     Daily.Total = 1:3,
#'     Outlet = "CHIPPENHAM")
#' print(x)
#' validObject(object = x)

setClass(Class = "SalesData",
    slots = c(
       Date = "Date",
       Daily.Total = "numeric",
       Outlet = "character"),
    prototype = prototype(
        Date = as.Date(NA),
        Daily.Total = NA_real_,
        Outlet = NA_character_), 
    validity = validSalesData)


