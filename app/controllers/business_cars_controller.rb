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

	def update
		@car = BusinessCar.find(params[:id])
		if @car.update_attributes(car_params)
			respond_to do |format|
				format.html { redirect_to business_cars_path}
				format.js
			end
		else
			render plain: "0"
		end
	end

	def destroy
		@car = BusinessCar.find(params[:id])
		if @car.destroy
			respond_to  do |format|	
				format.js {render plain: "1"}
				format.html {redirect_to business_cars_path}
			end
		else
			respond_to do |format|
				format.js { render plain: "0"}
				format.html { redirect_to business_cars_path, notice: "delete failed"}
			end
		end

	end
	def  car_params
		params.require(:business_car).permit(:make, :model, :mileage, :nickname)
	end
end