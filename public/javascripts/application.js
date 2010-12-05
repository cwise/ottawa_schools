$(function () {
    $('.capitalized_field').live('blur', function() {
		var words=$(this).val().split(" ");
	    for(var i = 0; i < words.length; ++i)
	        words[i] = words[i].charAt(0).toUpperCase() + words[i].substring(1);

	    $(this).val(words.join(" "));	
    });
	
	$(".button").button();	
});