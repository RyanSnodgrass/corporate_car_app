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

Then the model
```ruby
class BusinessCar < ActiveRecord::Base
  validates :mileage, numericality: true
  belongs_to :driver
end

class Driver < ActiveRecord::Base
  has_many :business_cars
end
```

I created a seed file to have only one driver
```ruby
# db/seeds.rb
Driver.delete_all
Driver.create(name: "Bruce Mclaren")
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

Next we need a partial for the car thumbnail
```haml
/ app/views/business_cars/_business_car.html.haml
%li{id: "car_#{c.id}"}
  .car-div
    .small-6.columns
      .car-box
        .small-6.columns
          %h2= c.nickname
          %h5 Driver
          %h4= c.driver.name
          
        .small-6.columns
          %button.button.expand.bupdate{ data: { "businesscar-id" => c.id}}
            Update
        .small-6.columns
          %h5 Make
          %h4= c.make
        .small-6.columns
          %h5 Model
          %h4= c.model
        .small-6.columns  
          %h5 Mileage
          %h4= c.mileage
        .small-6.columns  
          %button.button.alert.expand.delete{ data: { "businesscar-id" => c.id}}
            Delete
.update_overlay{id: "update_car_#{c.id}"}
  .row
    .small-11.medium-9.large-6.small-centered.columns
      .modal
      
        = form_for c, remote: true do |f|

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
                = submit_tag "UPDATE CAR", class: "button success expand"
```



Creation
---

In the controller 

```ruby
# app/controllers/business_cars_controller.rb
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
```

The controller is responding to a create render. That makes it go to a create.json.bldr file
```
# app/views/create.json.bldr
object @new_car do |car|
  attribute(:driver) {car.driver.name}
  attributes :make, :model, :mileage, :nickname
end
```
Then we need to create a modal.js.coffee file to handle the incoming request to the view.  The `insert_car` variable is one way of inserting a new thumbnail into the view. If I wanted to do a partial, I'd have to instead do a `create.js.erb` file. Make sure to put it in your assets folder.
```coffee
# app/assets/javascripts/modal.js.coffee
$ ->
  insert_car = (id, make, model, mileage, nickname, driver_id) ->
    '<div class="small-6 columns"><div class="car-box"><div class="small-6 columns"><h2>' + nickname + '</h2><h5>Driver</h5><h4>' + driver_id + '</h4></div><div class="small-6 columns"><button class="button expand">Update</button></div><div class="small-6 columns"><h5>Make</h5><h4>' + make + '</h4></div><div class="small-6 columns"><h5>Model</h5><h4>' + model + '</h4></div><div class="small-6 columns"><h5>Mileage</h5><h4>' + mileage + '</h4></div><div class="small-6 columns"><button class="button alert expand delete" data-businesscar-id="' + id + '">Delete</button></div></div></div>'

  $add_modal = $('.add_overlay')
  
  $('.add').on 'click', ->
		$add_modal.fadeIn 'fast'
		
	
  
  # This is what hapens after remote: true.
  $('form#new_business_car').on 'ajax:complete', (event, data, status, xhr) ->
    console.log(data)
    car = $.parseJSON(data.responseText)
    console.log(car)
    $('#itemlist').append insert_car(car.id, car.make, car.model, car.mileage, car.nickname, car.driver)
    $add_modal.hide();
```
