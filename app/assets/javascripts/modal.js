$( function () {
	var modal = $('.overlay');
	
	$('.add').on('click', function() {
		modal.fadeIn('fast');

	});

	$('.close-reveal-modal').on('click', function() {
		modal.fadeOut('slow');
	});

	$('.delete').on('click', function() {
		var box = $(this).parents('.car-div');
		var car_id = $(this).attr('data-businesscar-id');
		console.log(car_id);

		$.ajax({
			url: "/business_cars/" + car_id,
			type: 'DELETE',

			success: function(data){
				if(data == "1") {
					console.log(data);
					console.log('this succeeded');
					// $('.car-box').append(data);
				}
				else {
					console.log(data);
					console.log('this failed');
					$(row).addClass(".failed");
				}
			}
		});

	});

	$('form').submit(function () {
		var valuesToSubmit = $(this).serialize();
		
		$.ajax({
			url: "/business_cars/",
			
			data: valuesToSubmit,
			type: "POST",
			success: function(data){
				console.log('before if statement');
				if(data === "0") {
					
					console.log(data);
					modal.hide('slow');
				}
				else {
					console.log("inside if statement");
					console.log(data);
					location.reload(true);
					// $('ul').append(data);
					modal.fadeOut();

				
					
				}
			}
		});	
		return false;
	});
});