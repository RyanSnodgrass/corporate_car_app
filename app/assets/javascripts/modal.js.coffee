$ ->
	insert_car = (id, make, model, mileage, nickname, driver) ->
		'<div class="small-6 columns"><div class="car-box"><div class="small-6 columns"><h2>' + nickname + '</h2><h5>Driver</h5><h4>' + driver + '</h4></div><div class="small-6 columns"><button class="button expand">Update</button></div><div class="small-6 columns"><h5>Make</h5><h4>' + make + '</h4></div><div class="small-6 columns"><h5>Model</h5><h4>' + model + '</h4></div><div class="small-6 columns"><h5>Mileage</h5><h4>' + mileage + '</h4></div><div class="small-6 columns"><button class="button alert expand delete" data-businesscar-id="' + id + '">Delete</button></div></div></div>'


	add_modal = $('.add_overlay')
	update_modal = $('.update_overlay')

	$('.add').on 'click', ->
		add_modal.fadeIn 'fast'

	$('.add').on 'click', ->
		add_modal.fadeIn 'fast'	



	$('.close-reveal-modal').on 'click', ->
		add_modal.fadeOut 'slow'

	$(document).on 'click', '.delete', ->
		box = $(this).parents '.car-div'
		car_id = $(this).attr 'data-businesscar-id'
		console.log(car_id)

		$.ajax '/business_cars/' + car_id,
			type: 'DELETE'

			success: (data) ->
				if data == "1"
					console.log data
					console.log 'this succeeded'
					$(box).fadeOut 'slow'
				else
					console.log data
					console.log 'this failed'

	$('form#new_business_car').on 'ajax:complete', (event, data, status, xhr) ->
		console.log(data)
		car = $.parseJSON(data.responseText)
		console.log(car)
		$('#itemlist').append insert_car(car.id, car.make, car.model, car.mileage, car.nickname, car.driver)
	
	$(document).on 'click', '.bupdate', ->
		car_id = $(this).attr 'data-businesscar-id'
		$('.update_overlay').fadeIn 'fast'
		

	# $('form').on 'submit', (event) ->
	# 	valuesToSubmit = $(this).serialize
	# 	console.log 'before ajax'
		
	# 	$.ajax "/business_cars",
	# 	datatype: "JSON"
	# 	data: valuesToSubmit
	# 	type: "POST"

	# 	success: (data) ->
	# 		console.log 'before if statement'
	# 		if data == "0"
	# 			console.log(data)
	# 			modal.hide('slow')
	# 		else
	# 			console.log 'inside else statement'
	# 			console.log(data)
	# 			$("#itemlist").append insert_car(data.id, data.make, data.model, data.mileage, data.nickname)
	# 			modal.fadeOut

