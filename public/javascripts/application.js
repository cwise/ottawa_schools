function load_buttons() {
	$(".button").button();	
}

$(function () {
	load_buttons();
	
	$('#notice').notice({type: 'alert', animate: false, autoShow: true, widgetClass: 'ui-helper-reset ui-widget', innerBoxClass: 'ui-corner-all ui-notice-inner'});
	$('#alert').notice({type: 'error', animate: false, autoShow: true, widgetClass: 'ui-helper-reset ui-widget', innerBoxClass: 'ui-corner-all ui-notice-inner'});
});