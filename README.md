About
===

Built as an example for AJAX CRUDing.

I'm using Bldr gem for JSON templating.

Development
===

First get your tables set

```ruby

create_table "business_cars", force: true do |t|
    t.string  "make"
    t.string  "model"
    t.integer "mileage"
    t.string  "nickname"
    t.integer "driver_id", default: 1
  end

  create_table "drivers", force: true do |t|
    t.string "name"
  end
```

Then your routes

```ruby
  resources :business_cars
  root 'business_cars#index'
```

Then your view

```haml
/ app/views/business_cars/index.html.haml
.add_overlay
	.row
		.small-11.medium-9.large-6.small-centered.columns
			.modal
				= form_for BusinessCar.new, remote: true do |f|
					.row
						.small-11.columns
						.small-1.columns
							%a.close-reveal-modal ×
					.row
						.small-9.small-centered.columns
							= label_tag :make, nil
							= f.text_field :make
							%br

							= label_tag :model, nil
							= f.text_field :model
							%br
							= label_tag :mileage, nil
							= f.text_field :mileage
							%br
							= label_tag :nickname, nil
							= f.text_field :nickname
							.small-6.small-centered.columns.end
								= submit_tag "ADD CAR", class: "button success expand"
%nav.top-bar{"data-topbar" => ""}
	%ul.title-area
		%li.name
			%h1
				%a Business Car App
.jaguar-top-banner
	= image_tag('jaguar_top_banner.jpg')
.first-point-banner
	.small-11.medium-9.large-7.small-centered.columns
		.line-break
			%h1 In a world of constant travel
		.line-break	
			%h1 Meetings half way across the city
		
		%h1 It's nice to keep track of the corporate car
.second-point-banner
	.row
		%ul#itemlist
			-@cars.each do |c|
				= render "business_car", c: c

.add-banner
	.row
		.small-4.small-centered.columns
			.add-button
				%button.button.expand.success.add
					Add a Car
```
Creation
---

In the controller 

```ruby
class BusinessCarsController < ApplicationController
	# respond_to :json
	

	def index
		# @car = BusinessCar.build
		@cars = BusinessCar.all
	end
	
	def create
		 @new_car = BusinessCar.new(car_params)
		if @new_car.save
			render :create
		else
			respond_to do |format|
				format.js { render plain: "0"}
			end
		end
	end
