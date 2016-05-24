
#' Coerce Sales Data to Data Frame
#' 
#' A method to coerce Sales Data to Data Frame.
#' 
#' @param x SalesData object.
#' @param \dots further arguments passed to or from other methods.
#' @docType methods
#' @rdname as.data.frame-methods
#' @aliases as.data.frame,SalesData
#' @exportMethod as.data.frame
#' @examples
#' x <- new(Class = "SalesData", 
#'     Date = as.Date(x = 1:3, origin = "2015-12-18"),
#'     Daily.Total = 1:3,
#'     Outlet = "CHIPPENHAM")
#' as.data.frame(x)

setMethod("as.data.frame", 
    signature("SalesData"), 
    function(x, ...) {
    data.frame(Date = slot(object = x, name = "Date"), 
        Daily.Total = slot(object = x, name = "Daily.Total"))
})


#' Print Sales Data
#' 
#' A method to print an object.
#' 
#' @param x SalesData object.
#' @param \dots further arguments passed to or from other methods.
#' @docType methods
#' @rdname print-methods
#' @aliases print,SalesData
#' @exportMethod print
#' @examples
#' x <- new(Class = "SalesData", 
#'     Date = as.Date(x = 1:3, origin = "2015-12-18"),
#'     Daily.Total = 1:3,
#'     Outlet = "CHIPPENHAM")
#' print(x)

setMethod("print", 
    signature("SalesData"), 
    function(x, ...) {
    message("SalesData for ", slot(object = x, name = "Outlet"))
    xdf <- as.data.frame(x)
    names(xdf) <- c("@Date", "@Daily.Total")
    return(xdf)
})

#' Find Unique Sales Data Daily.Total
#' 
#' A method to get unique Daily.Total.
#' 
#' @param x SalesData object.
#' @param \dots further arguments passed to or from other methods.
#' @docType methods
#' @rdname unique-methods
#' @aliases unique,SalesData
#' @exportMethod unique
#' @examples
#' x <- new(Class = "SalesData", 
#'     Date = as.Date(x = 1:3, origin = "2015-12-18"),
#'     Daily.Total = 1:3,
#'     Outlet = "CHIPPENHAM")
#' unique(x)

setMethod(f = "unique", 
    signature = signature(x = "SalesData"), 
    definition = function(x) {
        validObject(x)
        totals <- slot(object = x, name = "Daily.Total")
        return(unique(totals))
    }
)

