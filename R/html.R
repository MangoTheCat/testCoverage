writeReport <- function(unitTestList, sumTraces, allTraces, otablesNameless, sumOtables, sourceFileList, sourceCodeList, reportfile) {


	# Summary Table ------------------------------------------------------------
	sumAllTraces <- as.vector(table(factor(do.call(rbind, sumTraces)[, 2], 
	                                     levels = c("", "1"))))
	sumAllTraces[1] <- sumAllTraces[1] + sumAllTraces[2]
	sumAllTracesMat <- rbind(c(sumAllTraces, 
	                         sprintf("%3.f%%", 100 * sumAllTraces[2]/sumAllTraces[1])))
	colnames(sumAllTracesMat) <-  c("Total # Tracepoints", "# Executed", 
	                              "% Coverage")
	rownames(sumAllTracesMat) <- packagename

	sumAllTracesHTMLTable <- print.xtable(xtable(sumAllTracesMat), 
                                          type = "html", 
                                          print.results = FALSE, 
                                          sanitize.colnames.function = function(z) { z }, 
                                          html.table.attributes = "class=\"table table-bordered\"")
    
	# Generate a button for each unit test file. -------------------------------
    generateButton <- function(x) 
		paste0("<button type='button' class='btn btn-default' id='run_", 
			x["id"], "'>", x["name"], "</button>&nbsp;")
	
	buttonHTML <- vapply(unitTestList, generateButton, "")
    buttonHTML <- paste(buttonHTML, collapse = '')
    
    unitTestHTML <- paste0(
	'<h2>', attr(unitTestList, "testFramework"), ' Tests</h2>
	<button type="button" class="btn btn-default" id="trace_all">All Tests</button>&nbsp;',
	buttonHTML)

	# Generate a tab for each source file. -------------------------------------
	generateProgressTab <- function(x)
		paste0('<li class="', x["class"], 
			'"><a role="tab" data-toggle="tab" href="#tabs-', x["id"], '">', 
            x["name"], '</a><div id="progress-', x["id"], '" ></div></li>', '\n')

	tabHTML <- vapply(sourceFileList, generateProgressTab, "")
	tabHTML <- paste(tabHTML, collapse = '')

	#Generate a tab pane for each source file. ---------------------------------
	generateTabPane <- function(x)
	paste0('<div class="tab-pane ', x["class"], '" id="tabs-', x["id"], '">', 
		"<pre>", x["code"], "</pre></div>")

	tabPaneHTML <- vapply(sourceCodeList, generateTabPane, "")
	tabPaneHTML <- paste(tabPaneHTML, collapse = '')

    # Final assembly -----------------------------------------------------------
    reportHTML <- paste0(
      '<!DOCTYPE html>
<html>
<head>
  <title>testCoverage Report ', packagename, '</title>', 
      linkText, 
      styleText, 
      '
</head>
<body>
  <script>
  var sumTraces = ', toJSON(sumTraces), ";\n", 
      'var allTraces = ', toJSON(allTraces), ";\n", 
      'var coverage = ', toJSON(otablesNameless), ";\n", 
      'var all_coverage = ', toJSON(sumOtables), ";\n", 
      'var sumAllTraces = ', toJSON(sumAllTraces), ";\n", 
      htmlBuildText, 
      '
$( document ).ready(function() {
  $(".internet-connectivity").hide();
})
  </script>
  <div class="alert alert-danger internet-connectivity" role="alert"><h1><strong>Warning:</strong> An internet connection is required to load external assets.</h1></div>
  <div class="container">
  <div class="jumbotron">
    <h1>testCoverage Report <small>', packagename, '</small></h1>
  </div>
  <h2>Summary</h2>
', 
      sumAllTracesHTMLTable, 
      unitTestHTML, 
      '<h2>Resource Files</h2>', 
      '<div class="row">
       <div class="col-md-4">
        <ul class="nav nav-pills nav-stacked" role="tablist">', 
        tabHTML, 
      '</ul>
    </div> 
    <div class="col-md-8">
    <div class="tab-content">', 
    tabPaneHTML, 
      '
    </div>
    </div>
  </div>
  <div class="footer">
    <p> Generated on', Sys.time() , ' by <a href="http://www.mango-solutions.com/wp/products-services/r-services/r-packages/testcoverage/">testCoverage</a>.</p>
  </div>
  </div>
</body> 
</html>')
    
    write(reportHTML, reportfile)
    cat("Output to", reportfile, "\n")
    browseURL(reportfile)
}


