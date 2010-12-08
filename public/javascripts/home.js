function calculate_content_height() {
	win_height=jQuery(window).height();    	 
	header_height=jQuery("#search").outerHeight();
	content_height=(win_height-header_height-10);
	
	return content_height;  	  
};


function calculate_map_width() {
	win_width=jQuery(window).width();    	 
	results_width=jQuery("#results").outerWidth();    	 
	map_width=(win_width-results_width-18);

	return map_width;  	  
};

jQuery(window).resize(function() {
	jQuery("#results").height(calculate_content_height());
	jQuery("#map").height(calculate_content_height());    	
	jQuery("#map").width(calculate_map_width());  	
});

jQuery(document).ready(function() {
	jQuery("#results").height(calculate_content_height());
	jQuery("#map").height(calculate_content_height());    	
	jQuery("#map").width(calculate_map_width());   
});	
