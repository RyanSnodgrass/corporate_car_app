$( function () {
	var modal = $('.overlay');
	
	$('.add').on('click', function() {
		modal.css({
			"display": "initial"
		});
	});

	$('.close-reveal-modal').on('click', function() {
		modal.css({
			"display": "none"
		});		
	});
});