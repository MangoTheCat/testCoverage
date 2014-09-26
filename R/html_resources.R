# SVN revision:   $
# Date of last change: 2014-09-26 $
# Last changed by: $LastChangedBy: ttaverner $
# 
# Original author: ttaverner
# Copyright Mango Solutions, Chippenham, UK 2013
###############################################################################

linkText <- paste0('
    <link rel=\"stylesheet\" href=\"http://code.jquery.com/ui/1.11.1/themes/black-tie/jquery-ui.css\" />
    <link rel=\"stylesheet\" href=\"http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css\">
    <link rel=\"stylesheet\" href=\"http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css\">
    
    <script src=\"http://code.jquery.com/jquery-2.1.1.min.js\"></script>
    <script src=\"http://code.jquery.com/ui/1.11.1/jquery-ui.min.js\"></script>
	  <script src=\"http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js\"></script>')

styleText <- '<!--<script>
        $(function() {
          $( "#tabs" ).tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
          $( "#tabs li" ).removeClass( "ui-corner-top" ).addClass( "ui-corner-left" );
        });
    </script>-->
    <style>
	.footer {
		padding-top: 19px;
		color: #777;
		border-top: 1px solid #e5e5e5;
	}
  .btn,
  .nav-pills>li>a,
  .ui-corner-all,
  .ui-corner-top,
  .ui-corner-left,
  .ui-corner-tl {
    border-radius: 0;
  }
  .ui-widget-header {
    border: 1px solid #aaa;
  	background: #FAA531;
  	color: #222222;
  	font-weight: bold;
  }
  .fail {
    color: #A94442;
  background-color: #F2DEDE;
  }
  .pass {
    color: #3C763D;
  background-color: #DFF0D8;
  }
    </style>'
  

#tagList, sumTags, allTags
htmlBuildText <- 
'docolor = function(j, bb) {
// $("#t_" + tagList[j]).css("backgroundColor", bb ? "lightgreen" : "lightpink");
    if(bb > 0) {
        $("#t_" + tagList[j]).removeClass("fail").addClass("pass");
	} else {
        $("#t_" + tagList[j]).removeClass("pass").addClass("fail");
    }
};
pbsummed = function(j, cov) {
    pct = 100 * (cov[0] / (cov[0] + cov[1]));
    $("#progress-" + (j + 1)).progressbar({
        value: pct
    });
};
$(document).ready(function() {
    $.each(sumTags, docolor);
    $.each(all_coverage, pbsummed);
    $("#trace_all").click(function() {
        $.each(sumTags, docolor);
        $.each(all_coverage, pbsummed)
    });
    $.each(allTags, function(i, dum) {
        $("#run_" + (i + 1)).click(
            function() {
                $.each(allTags[i], docolor);
                $.each(coverage[i], function(j, cov) {
                    pct = 100 * (cov[0] / (cov[0] + cov[1]));
                    $("#progress-" + (j + 1)).progressbar({
                        value: pct
                    });
                })
            });
    });

    //This will only run if jQuery has loaded.
    $(".internet-connectivity").hide();
});'
