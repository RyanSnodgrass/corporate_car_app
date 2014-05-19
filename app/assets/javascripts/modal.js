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
					$(box).hide('slow');
				}
				else {
					console.log(data);
					console.log('this failed');
					$(row).addClass(".failed");
				}
			}
		});

	});

	$('form').on('submit', function (){
		var valuesToSubmit = $(this).serialize();
		console.log('before ajax');
		$.ajax({
			url: $(this).attr('action'),
			datatype: "JSON",
			data: valuesToSubmit,
			type: "POST"
		}).success(function(data){

				console.log('before if statement');

				if(data === "0") {
					
					console.log(data);
					modal.hide('slow');
				}
				else {
					console.log("inside if statement");
					console.log(data);
					// $(data).appendTo('itemlist');
					// $('ul').append(data);
					modal.fadeOut();

				
					
				}
			});
		});	
		// return false;
	});
