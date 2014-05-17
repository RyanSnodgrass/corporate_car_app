class BusinessCarsController < ApplicationController
	def index
		@cars = BusinessCar.all
	end
	def create
		@new_car = BusinessCar.new(car_params)
		if @new_car.save
			respond_to do |format|
				flash[:notice]= "Corporate Car was created!"
				format.js { render plain: "1"}
				format.html { redirect_to business_cars_path}
			end
		else
			respond_to do |format|
				flash[:notice] = "Error, try again"
				format.js { render plain: "0"}
				format.html { redirect_to(@new_car)}
			end
		end
	end
	def  car_params
		params.require(:business_car).permit(:make, :model, :mileage, :nickname)
	end
end