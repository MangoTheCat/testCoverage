# Date of last change: 2014-09-26 $
# Last changed by: $LastChangedBy: ttaverner $
# 
# Original author: ttaverner
# Copyright Mango Solutions, Chippenham, UK 2013-2014
###############################################################################

# @title make div
# @param open single logical
# @param id single logical
# @return character html

makeDiv <- function(open = TRUE, id = NULL) {
  paste0("<", if (!open) "/", "div", 
         if(!is.null(id)) paste0(" id=\"", id, "\""), ">")
}


# @title make tag
# @param open single logical
# @param id single integer identifying function being traced
# @param metastring single integer identifying analysis script
# @return character html

makeTag <- function(open = TRUE, id = NULL, metastring = NULL) {
  tag <- "<"
  if (open) {
    if (!(is.null(metastring) || metastring == "")) 
      metastring <- paste0("_", metastring) 
    if (!(is.null(id) || id == "")) 
      id <- paste0("_", id) 
    
    tag <- paste0(tag, "span id=\"t", metastring, id, "\">")
  } else {
    tag <- paste0(tag, "/span>")
  }
  return(tag)
}


# @title add tags
# @param idtags character matrix
# @param open single logical (default TRUE)
# @param gpd data frame with columns id, token, parsed from source file
# @param idtouse single integer symbol on which to report
# @param metastring single integer page to use
# @return character matrix

addTags <- function(idtags, open = TRUE, gpd, idtouse, metastring = NULL) {
  idx <- ifelse(open, 1, 3)
  gpdToken <- gpd$token
  gpdid <- gpd$id
  for(ii in seq_len(nrow(gpd))) {
    
    shift <- -(gpdToken[ii] %in% c("SYMBOL_FUNCTION_CALL")) * 1L
    
    l1 <- as.numeric(gpd[ii + shift, 1:4, drop = TRUE])
    
    if (gpdid[ii] %in% idtouse) {
      
      tag <- makeTag(open = open, id = gpdid[ii], metastring = metastring)
      
      idtags[l1[idx], l1[idx + 1]] <- paste0(idtags[l1[idx], l1[idx + 1]], tag)
    }
  }
  return(idtags)
}


# @title get parse tree for test code and build tag tree in html
# @param fn Sourcefile
# @param gpd Parsed data.
# @param metastring single integer
# @param idtouse single integer
# @return character vector

buildHTMLForParsedCode <- function(fn, gpd, metastring = NULL, idtouse = NULL) {
  
  text <- attr(gpd, 'srcfile')$lines
  text <- gsub("\\t", "        ", text)
  chars <- strsplit(text, "")
  maxlc <- max(sapply(chars, length))
  idTags <- matrix("", length(text), maxlc)
  chars <- do.call(rbind, lapply(chars, function(z) c(z, rep("", maxlc - length(z)))))
  chars[chars == "<"] <- "&lt;"
  chars[chars == ">"] <- "&gt;"
  
  ## Sandwich the code between span tags
  idTags <- addTags(idtags = idTags, open = TRUE, gpd = gpd, idtouse = idtouse, 
                    metastring = metastring)
  idTags <- array(paste0(idTags, chars), dim(idTags))
  idtags <- addTags(idtags = idTags, open = FALSE, gpd = gpd, idtouse = idtouse, 
                    metastring = metastring)
  
  taggedLines <- apply(idtags, 1, paste0, collapse = "")
  paste0(taggedLines, collapse = "\n")
}


# TODO: separate function calling and report building utilities
# Function which orchestrates instrumentation of R source code functions, 
# runs execution files (e.g. unit tests), 
# collects results and builds output tables and HTML report.
# 
# @title build the html report
# @param sourcefiles vector string Path to source files.
# @param executionfiles vector string Path to test files to execute.
# @param packagename single string Name of package.
# @param reportfile single character (default "test.html")
# @param ignorelist List of functions to not trace within (default "")
# @param verbose single logical should \code{fcat} be verbose? (default TRUE)
# @param outputfile single character (default "traceOutput.txt")
# @param traceonce single logical (default TRUE)
# @param writereport single logical (default TRUE) should the HTML report be created?
# @param clean single logical (default FALSE) should trace tables be removed?
# @param refnamespaces affects the namespace reference behavior
# @return a list, first is a table of total traced points and executed points per test script, 
#         second is a list executed v.s. not executed per test script
# 
# @import xtable rjson 

buildHTMLReport <- function(sourcefiles, executionfiles, 
                            packagename = "",
                            reportfile = "test.html", 
                            outputfile = "traceOutput.txt", 
                            writereport = TRUE, clean = FALSE, ignorelist = "", 
                            verbose = TRUE, traceonce = TRUE, 
                            refnamespaces = NULL, isrunit = FALSE) {
                            
                            
  .g <<- new.env()
  
  ## Remove .onAttach if it exists, so we can test if .onAttach is introduced 
  ## source files
  if(exists(".onAttach", envir=.GlobalEnv)) {
    fcat("Removing .onAttach from global environment\n")
    rm(.onAttach, envir = .GlobalEnv)
  }
  .g$verbose <- verbose
  .g$ignorelist <- ignorelist
  # using full path avoiding possible change dir directory in the test scripts
  .g$outputfile <- suppressWarnings(normalizePath(outputfile)) 
  .g$traceonce <- traceonce
  .g$traceRecord <- NULL
  .g$idsSet <- NULL
  .g$appendOutput <- FALSE # possibly optional?
  
  with(.g, cat("\n", file = outputfile, append = appendOutput))
  
  NF <- length(sourcefiles)
  NE <- length(executionfiles)
  
  sourceCodeList <- vector(mode = "list", length = NF)
  sourceFileList <- vector(mode = "list", length = NF)
  
  lastNumFunDefInSrc <- 0
  
  # Iterate through source files -----------------------------------------------
  for (fileid in seq_len(NF)) {
    
    # Auto select first file.
    if(fileid == 1) 
      tabClass <- "active"
    else
      tabClass <- ""
      
    sourcefile <- sourcefiles[fileid]
    fcat(" ", fileid, basename(sourcefile), "... ", verbose = verbose)
    
    rv <- createTracedExpression(sourcefile = sourcefile, fileid = fileid, 
                                 envname = '.g')
    if (is.null(rv)) {
      fcat(" ", fileid, basename(sourcefile), "is empty, skipped\n", 
           verbose = verbose)
        sourceCodeList[[fileid]] <- c(class = tabClass, id = fileid, code =  paste0(readLines(sourcefile), collapse = "\n"))
        sourceFileList[[fileid]] <- c(class = tabClass, id = fileid, name = basename(sourcefile))           
      next
    }
    
    tracedExpression <- rv$tracedExpression
    
    gpd <- rv$parsedData
    
    fcat(" Evaluating instrumented code from", basename(sourcefile), "in Global Env\n", verbose = verbose)
    
    # TODO improvement:
    # do not allow .g$outputfile to be updated, 
    # perhaps by copying file to temp, then overwriting
    # 
    # alternatively replace with data frame in .g
    
    eval(tracedExpression, .GlobalEnv)
    
    thisNumFunDefInSrc <- nrow(read.table(.g$outputfile))
    fcat(" removing", thisNumFunDefInSrc - lastNumFunDefInSrc, 
         "trace points for assigning... \n", verbose = verbose)
    lastNumFunDefInSrc <- thisNumFunDefInSrc

    
    ## build <span> html
    ## only generate span ids that are actually set
    idsSetHere <- .g$idsSet[.g$idsSet[, 1] == fileid, 2, drop = TRUE]

    sourceCodeList[[fileid]] <- c(class = tabClass, id = fileid, code = buildHTMLForParsedCode(sourcefile, gpd, metastring = fileid, idtouse = idsSetHere))
    sourceFileList[[fileid]] <- c(class = tabClass, id = fileid, name = basename(sourcefile))
  }
  
  
  ## this contains the output from eval-ing the source files themselves
  ## e.g. assigning functions
  funDefInSrc <- read.table(.g$outputfile)
  ## CCT-7, remove the function definition code
  .g$idsSet <- .g$idsSet[!(paste(.g$idsSet[, 1], .g$idsSet[, 2]) %in% 
                             paste(funDefInSrc[, 1], funDefInSrc[, 2])), , drop = FALSE]
  dfIDsSet <- data.frame(.g$idsSet)
  ## This is a long vector that looks like c("2_71", "2_83", "2_86", "2_108", "2_304", ...)
  ## Contains symbol names  
  strIDsSet <- do.call(paste, c(dfIDsSet, sep = "_"))  
  ## This is updated when strIDsSet names are "hit"
  sumIDsHit <- numeric(length(strIDsSet))

   
  unitTestList <- list()
  if(isrunit){
    attr(unitTestList, "testFramework") <- "RUnit"
  } else {
    attr(unitTestList, "testFramework") <- "testthat"
  }
  
  allTraces <- vector(mode = "list", length = NE)
  sumTraces <- c()
  
  ## This assumes the "1:n" source file naming scheme.
  source_file_ids <- seq_len(NF)
  
  ## Adding "empty" levels ensures files with no tests get included properly.
  ## This is due to the use of table() to count hits below.
  dfIDsSet[,1] <- factor(dfIDsSet[, 1], levels = source_file_ids)  
      
  table_of_execution <- matrix(table(dfIDsSet[, 1]), nrow = 1, 
                               ncol = NF)
  colnames(table_of_execution) <- basename(sourcefiles) ## [ source_file_ids ]
  rownames(table_of_execution) <- 'Trace Points'
  ErrorOccurred = logical(NE)
  
  otables <- vector("list", NE)
  names(otables) <- basename(executionfiles)

  ## If we've loaded an .onAttach, we need to call it.
  ## Might also do this for ".First.Lib" for pre-2.14 R
  if(exists(".onAttach", envir=.GlobalEnv)){
    fcat(".onAttach was defined. Calling package .onAttach\n")
    tryCatch(get(".onAttach", envir=.GlobalEnv)("", ".GlobalEnv"), error=function(e) print(e))
  }

  # Mask ::: and q() before executing tests. -----------------------------------
  if (!is.null(refnamespaces)) {
    `:::` <- function(pkg, name) {
      m <- match.call()
      pkg <- as.character(substitute(pkg))
      name <- as.character(substitute(name))
      if (pkg %in% refnamespaces) {
        fcat(sprintf('Execution file has a %s:::%s reference\n', pkg, name), 
             verbose)
        return(get(name, envir = .GlobalEnv, inherits = FALSE))
      }
      m[[1]] <- get(':::', envir = asNamespace('base')) 
      eval(m)
    }
  }
  # protect "q()"
  assign("q", function(...) { warning("q() called from test script!") }, 
         envir = .GlobalEnv)
  assign("q", function(...) { warning("q() called from test script!") }, 
         envir = environment())
  on.exit(rm("q", envir = .GlobalEnv))
  
  # Iterate through unit test files. -------------------------------------------
  for (idx in seq_along(executionfiles)) {
    
    executionFile <- executionfiles[[idx]]

    fcat(idx, ": reading", basename(executionFile), "...", verbose = verbose)
    tryCatch({
      if (file.exists(.g$outputfile)) { unlink(.g$outputfile, force = TRUE) }
      
      if (regexpr('^runit', basename(executionFile))>0) {
        # RUnit
        runTestFile(executionFile)
      } else {
        
        source(executionFile, local = TRUE)
      }
      fcat("OK.\n", verbose = verbose)
    }, error = function(e) {
      fcat(idx, basename(executionFile), "failed with error\n", 
           verbose = verbose)
      ErrorOccurred[idx] <<- TRUE
      print(e)
    })
    
    # if failed .g$outputfile remain old values
    # Worse, like "test-parallel.r" in plyr, it actually does nothing and does 
    # not report an error. we have to remove the .g$outputfile of last round

    if (file.exists(.g$outputfile)) {
      strOutput <- do.call(paste, c(read.table(.g$outputfile), sep = '_'))
    } else {
      strOutput <- character(0)
    }
    ## add summary table to start
    idSeen <- strIDsSet %in% strOutput
    sumIDsHit <- sumIDsHit + idSeen
    tmp.table <- table(dfIDsSet[idSeen, 1])
    
            
    table_of_execution <- rbind( table_of_execution, tmp.table )
    otable <- table(factor(idSeen, levels = c(TRUE, FALSE)), dfIDsSet[, 1])
    rownames(otable) <- c("Executed", "Not Executed")
    colnames(otable) <- basename(sourcefiles)[ as.integer(colnames(otable)) ]
    otables[[basename(executionFile)]] <- otable

    unitTestList[[idx]] <- c(id = idx, name = basename(executionFile))

    allTraces[[idx]] <- strOutput
    sumTraces <- c(sumTraces, strOutput)
  }

  # Compute coverage -----------------------------------------------------------

  names(otables) <- basename(executionfiles)
  rownames(table_of_execution)[-1] <- basename(executionfiles)
  otablesNameless <- lapply(otables, function(z) {
    class(z) <- "matrix"
    z <- as.list(as.data.frame(z))
    names(z) <- NULL
    return(z)
  })
  names(otablesNameless) <- NULL

   
  # Summary traces -------------------------------------------------------------
  sumTracesTable <- split(cbind(strIDsSet, ifelse(strIDsSet%in%sumTraces, "1", "")), 
                     strIDsSet)
  names(sumTraces) <- NULL
  
  # Summary object table -------------------------------------------------------
  sumOtablesMat <- table(factor(sumIDsHit > 0, levels = c(TRUE, FALSE)), 
                      dfIDsSet[, 1])
  class(sumOtablesMat) <- "matrix"
  
  sumOtables <- as.list(as.data.frame(sumOtablesMat))
  names(sumOtables) <- NULL
  sumOtable <- as.vector(table(factor(do.call(rbind, sumTracesTable)[, 2], 
                                      levels = c("", "1"))))
  
  sumTags <- 1*(strIDsSet %in% sumTraces)
  allTags <- lapply(allTraces, function(z) 1*(strIDsSet %in% z))  
  
  # Write report ---------------------------------------------------------------
  if (writereport) 
    writeReport(unitTestList, strIDsSet, sumTags, allTags, otablesNameless, sumOtables, 
                sourceFileList, sourceCodeList, reportfile)
  
  if (clean)  
    if (file.exists(outputfile)) 
      unlink(outputfile) 
  
  return(list(A = table_of_execution, E = ErrorOccurred, B = otables))
}
