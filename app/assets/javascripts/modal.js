$( function () {
	var modal = $('.overlay');
	
	$('.add').on('click', function() {
		modal.slideDown('fast');
	});

	$('.close-reveal-modal').on('click', function() {
		modal.slideUp('slow');
	});

	$('form').submit(function () {
		var valuesToSubmit = $(this).serialize();
		
		$.ajax({
			url: $(this).attr('create'),
			
			data: valuesToSubmit,
			type: "POST",
			success: function(data){
				if(data == "1") {
					modal.css({
					"display": "none"
					});					
				}
				else {
					modal.hide('slow');
				}
			}
		});	

	});
});