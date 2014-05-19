$( function () {
	
	function insert_car(id, make, model, mileage, nickname) {
		return '<div class="small-6 columns"><div class="car-box"><div class="small-6 columns"><h2>' + nickname + '</h2></div><div class="small-6 columns"><button class="button expand">Update</button></div><div class="small-6 columns"><h5>Make</h5><h4>' + make + '</h4></div><div class="small-6 columns"><h5>Model</h5><h4>' + model + '</h4></div><div class="small-6 columns"><h5>Mileage</h5><h4>' + mileage + '</h4></div><div class="small-6 columns"><button class="button alert expand delete" data-businesscar-id="' + id + '">Delete</button></div></div></div>'

	}

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
					$(box).fadeOut('slow');
				}
				else {
					console.log(data);
					console.log('this failed');
					$(row).addClass(".failed");
				}
			}
		});

	});

	$('form').on('submit', function (event){
		var valuesToSubmit = $(this).serialize();
		console.log('before ajax');
		

		$.ajax({
			url: "/business_cars",
			datatype: "JSON",
			data: valuesToSubmit,
			type: "POST",
			
			success: function(data){


				console.log('before if statement');

				if(data === "0") {
					
					console.log(data);
					modal.hide('slow');
				}
				else {
					console.log("inside else statement");
					console.log(data);
					$("#itemlist").append(insert_car(data.id, data.make, data.model, data.mileage, data.nickname));
					// $('ul').append(data);
					modal.fadeOut();

				
					
				}
			}
		
		});	
event.preventDefault();
		// return false;
	});
});
