class BusinessCarsController < ApplicationController
	respond_to :json

	def index
		@cars = BusinessCar.all
	end
	def create
		if @new_car = BusinessCar.create(car_params)
			# respond_to do |format|
				# flash[:notice]= "Corporate Car was created!"
				# render json: @new_car
				 render json: @new_car
				# format.html { redirect_to(@new_car)}
				
			# end
		else
			respond_to do |format|
				
				format.js { render plain: "0"}
				
			end
		end
	end
	def destroy
		@car = BusinessCar.find(params[:id])
		if @car.destroy
			render plain: "1"
			# respond_to |format|
			# 	format.js {render plain: "1"}
			redirect_to business_cars_path
			end
		else
			respond_to do |format|
				format.js { render plain: "0"}
				format.html { redirect_to business_cars_path, notice: "delete failed"}
			end

	end
	def  car_params
		params.require(:business_car).permit(:make, :model, :mileage, :nickname)
	end
end