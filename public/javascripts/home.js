function calculate_content_height() {
	win_height=jQuery(window).height();    	 
	header_height=jQuery("#header").outerHeight();
	content_height=(win_height-header_height-25);
	
	return content_height;  	  
};


function calculate_map_width() {
	win_width=jQuery(window).width();    	 
	results_width=jQuery("#results").outerWidth();    	 
	map_width=(win_width-results_width-18);

	return map_width;  	  
};

$(window).resize(function() {
	$("#results").height(calculate_content_height());
	$("#map").height(calculate_content_height());    	
	$("#map").width(calculate_map_width());  	
});

$(document).ready(function() {
	$("#results").height(calculate_content_height());
	$("#map").height(calculate_content_height());    	
	$("#map").width(calculate_map_width());   
});	
