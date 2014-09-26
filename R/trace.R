# SVN revision:   $
# Date of last change: 2014-09-25 $
# Last changed by: $LastChangedBy: ttaverner $
# 
# Original author: ttaverner
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################


# This function extracts elements of an expression. 
# If \code{pos} is length zero, the whole expression is returned.
# If \code{pos} is length one, that part of the expression is returned.
# If \code{pos} is length two or more, that nested element of the expression is returned.
# 
# @title return an element of an expression
# @param e expression
# @param pos numeric index length 0 or greater
# @return an element of a list
# @examples
#     expr <- expression(`_1_16` <-
#         function ( x , y ) { `_1_29` + `_1_32` })
#     testCoverage:::getAtPos(e = expr, pos = integer(0))
#     testCoverage:::getAtPos(e = expr, pos = 1)
#     testCoverage:::getAtPos(e = expr, pos = c(1, 1))

getAtPos <- function(e, pos) {

  if (!length(pos)) { return(e) }
  
  return(e[[pos]])
}

# The R scripts are read by \code{createTracedExpression} and symbols replaced with unique identifiers.
# These expressions are passed to \code{recurseInsertTrace} which uses \code{getAtPos} to extract elements.
# If the remaining expression is recursive, this function calls itself.
# At each level a call to \code{\_trace} is added using \code{substitute}. 
# 
# @title spider to recursively insert trace
# @param e expression
# @param envname single character (default '.g') environment with elements ignorelistRepl
# @param pos numeric index
# @param addtrace single logical should trace be added? (default \code{TRUE})
# @return expression
# @examples
#     expr <- expression(`_1_16` <-
#         function ( x , y ) { `_1_29` + `_1_32` })
#     testG <- new.env()
#     testG$ignorelistRepl <- character(0)
#     testCoverage:::recurseInsertTrace(e = expr, envname = 'testG', 
#        pos = integer(0), addtrace = TRUE)

recurseInsertTrace <- function(e, envname = '.g', pos = integer(0), 
  addtrace = TRUE) {
  
  x <- getAtPos(e = e, pos = pos)
  
  # if x is a name, it will be missing
  if (!missing(x)) {
    
    if (is.call(x) && !addtrace) {
      
      ignorelistRepl <- get("ignorelistRepl", envir = get(envname))
      
      firstSibling <- e[[c(pos[-length(pos)], 1)]]
      
      if (!(is.assign(firstSibling) && identical(pos[length(pos)], 2))) {
        
        if (length(firstSibling) == 1 && as.character(firstSibling) %in% 
          c("~", ignorelistRepl)) {
          
          return(e)
          
        } else {
          
          e[[pos]] <- substitute({
            `_trace`()
            `*tmp*`}, list(`*tmp*`= x))
        }
      }
    }
    if (!is.recursive(x)) { return(e) }
    
    idx <- 1
    
    while(TRUE) { # TODO: check opinions on whether this is nice syntax
      
      if (idx > length(getAtPos(e = e, pos = pos))) { break }
      
      e <- recurseInsertTrace(e = e, envname = envname, pos = c(pos, idx), 
        addtrace = !addtrace)
      
      idx <- idx + 1
    }
  }
  return(e)
}


# Take an expression, create a deparsed character vector of the expression.
# Search down the expression for \code{\_trace} calls.
# 
# @title recurse setup trace
# @param e list
# @param envname single character (default .g) environment
# @param pos numeric index
# @return expression

recurseSetupTrace <- function(e, envname = '.g', pos = integer(0)) {
  
  x <- getAtPos(e = e, pos = pos)
  
  if (missing(x)) { return(e) }
  
  dpx <- deparse(x)
  
  if (identical(x, quote(`_trace`()))) {
    assign("lastTrace", value = pos, envir = get(envname)) }
  
  if (is.name(x) && grepl("^_\\d+_\\d+$", dpx)) {
    
    lastTrace <- get("lastTrace", envir = get(envname))
    
    if (!is.null(lastTrace)) {
      
      dpxID <- as.integer(strsplit(dpx, "_")[[1]][-1])
      
      # replace the trace arg if it's not set already
      # Note: length(quote(`_trace`()))==1 and length(quote(`_trace`(c(1, 2))))==2 
      if (length(getAtPos(e = e, pos = lastTrace)) != 2) {
        
        if (identical(rev(lastTrace)[-1], rev(pos)[-(1:2)])) {
          
          set <- rbind(get("idsSet", envir = get(envname)), dpxID, 
            deparse.level = 0)
          
          assign("idsSet", value = set, envir = get(envname))
          
          e[[lastTrace]] <- substitute(`_trace`(`*tmp*`), list(`*tmp*` = dpxID))
        }
      }
    }
    
    gpd <- get("gpd", envir = get(envname))
    
	## If it's something like `%>%`, don't quote it again
	## Congratulations to Tal Galili
	matchingSymbol <- gpd$text[gpd$replText == paste0("`", dpx, "`")]
	if(grepl("^`.*`$", matchingSymbol)){
	  e[[pos]] <- parse(text=matchingSymbol)[[1]]
	} else {
      e[[pos]] <- as.symbol(matchingSymbol)
	}
  }
  
  if (is.recursive(x)) {
    
    for (idx in seq_along(getAtPos(e = e, pos = pos))) {
      
      e <- recurseSetupTrace(e = e, envname = envname, pos = c(pos, idx))
    }
  }
  return(e)
}


#' _trace expects an environment called .g to exist.
#' The function needs to be exported.
#' @title trace a function
#' @param idx Identifier.
#' @param envname single character (default '.g') environment to update
#' @export
#' @rdname testCoverage-internal

`_trace` <- function(idx = NULL, envname = '.g') {
 
    if (!missing(idx)) {
    
    traceRecord <- get("traceRecord", envir = get(envname))
    
    if (get("traceonce", envir = get(envname))) {
      
      if (paste(idx, collapse = "_") %in% traceRecord) {
        
        return(invisible(NULL))
        
      } else {
        
        assign("traceRecord", 
          value = c(traceRecord, paste(idx, collapse = "_")), 
          envir = get(envname))
      }
    }
    
    write.table(rbind(idx), file = get("outputfile", envir = get(envname)), 
      append = TRUE, row.names = FALSE, col.names = FALSE)
  }
  
  return(invisible(NULL))
}

# helper function for char.to.sym1

char.to.sym0 <- function(e) {
  changed <- FALSE
  if (is.call(e) && (e[[1]] == '=' || e[[1]] == '<-') && is.character(e[[2]])) {
    e[[2]] <- as.symbol(e[[2]])
    changed <- TRUE
  }
  attr(e, 'changed') <- changed
  return(e)
}

# helper function for char.to.sym

char.to.sym1 <- function(es) {
  if (is.list(es) || is.expression(es)) {
    changed <- FALSE
    for(i in seq_along(es)) {
      if (is.null(es[[i]])) next
      es[[i]] <- Recall(es[[i]])
      if (!changed && isTRUE(attr(es[[i]], 'changed'))) { changed <- TRUE }
    }
    attr(es, 'changed') <- changed
    return(es)
  } 
  char.to.sym0(es)
}

# only change those necessary ones
# If src has a 'symbol'<-value, convert it to symbol<-value, write to disk, and return parsed object of that changed text file

char.to.sym <- function(src) {
  if (length(src) == 0) { return(src) }
  es <- char.to.sym1(src)
  if (!isTRUE(attr(es, 'changed'))) { return(src) }
  fn <- paste0(tempfile(), '.R')
  tmpf <- file(fn, open = 'a')
  for (i in as.character(es)) {
    cat(i, '\n', file = tmpf)
  }
  close(tmpf)
  return(parse(fn, keep.source = TRUE))
}

# This function uses \code{getParseData} from package:utils to interpret the R script.
# It then replaces \code{"SYMBOL"} and \code{"SYMBOL_FUNCTION_CALL"} with a unique identifier.
# These unique identifiers can be used to track each time they are hit by the unit tests.
# Note that the total number of symbols including the function name, as well 
# as symbols within the functional code are traced and reported as being traced.
# @title create traced expression
# @param sourcefile single character path to file to source
# @param fileid single numeric
# @param envname single character (default '.g') naming environment to update containing elements ignorelist", "verbose"
# @return list with elements 'symbolExpression', 'tracedExpression', and 'parsedData'

createTracedExpression <- function(sourcefile, fileid, envname = '.g') {

  expr <- parse(sourcefile, keep.source = TRUE)
  if (length(expr)==0) return(NULL)
  expr = char.to.sym(expr)

  gpd <- getParseData(expr)
  
  gpd$replText <- gpd$text
  cnt = table(gpd$token)

  upbound.symbol.replace = options('maximal_symbol_replace')[[1]]
  if (is.null(upbound.symbol.replace)) upbound.symbol.replace = 15000

  if (isTRUE(cnt['SYMBOL'] > upbound.symbol.replace)) {
  # It will be too slow for that many symbols
    changeIDx <- gpd$token %in% c("SYMBOL_FUNCTION_CALL")
  } else {
    changeIDx <- gpd$token %in% c("SYMBOL", "SYMBOL_FUNCTION_CALL")
  }
  
  ## create new symbols of form _<file_num>_<symbol_num>
  gpd$replText[changeIDx] <- paste0("`_", fileid, "_", gpd$id, "`")[changeIDx]
  
  ## collapse the altered symbols to get equivalent code we can parse
  replText <- paste(sapply(split(gpd$replText, gpd$line1), paste0, 
    collapse = " "), collapse = "\n")
  
  ignorelist <- get("ignorelist", envir = get(envname))
  
  ## ignore list: don't add any tracers to here 
  ignorelistRepl <- gpd$replText[gpd$text %in% ignorelist]
  ## remove backticks
  ignorelistRepl <- substr(ignorelistRepl, start = 2, 
    stop = nchar(ignorelistRepl) - 1)
  
  ## the env .g lived in global -> moved to inside functions
  assign("ignorelistRepl", value = ignorelistRepl, envir = get(envname)) # read by recurseInsertTrace
  assign("gpd", value = gpd, envir = get(envname))
  
  verbose <- get("verbose", envir = get(envname))
  
  fcat("replacing", sum(changeIDx), "symbols... ", verbose = verbose)
  
  symTrace <- recurseInsertTrace(e = parse(text = replText), envname = envname, 
    addtrace = TRUE)
  
  ## go thru parse tree, set symbols back to originals and add args to trace
  # note that calls to function are currently traced although they are not instrumented
  # TODO check this is correct and prevent function from being instrumented if not needed
  # removed message to make behaviour easier to understand.
  #fcat("adding", length(gregexpr(pattern = "_trace", as.character(symTrace))[[1]]), "original trace points... ", verbose = verbose)

  assign("lastTrace", value = NULL, envir = get(envname))
  
  exprTrace <- recurseSetupTrace(e = symTrace, envname = envname)
  fcat("setting", length(gregexpr(
    pattern = "`_trace`\\(c", as.character(exprTrace))[[1]]), 
    "trace points... \n", verbose = verbose)
  
  attr(exprTrace, "srcref") <- NULL
  
  return(list(symbolExpression = symTrace, 
      tracedExpression = exprTrace, 
      parsedData = gpd))
}

