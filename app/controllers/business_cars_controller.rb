class BusinessCarsController < ApplicationController
	respond_to :js, :json

	def index
		@cars = BusinessCar.all
	end
	def create
		@new_car = BusinessCar.new
		if @new_car = BusinessCar.create(car_params)
			respond_to do |format|
				
				format.js { render json: @new_car}
				format.html { redirect_to business_cars_path}
				
			end
		else
			respond_to do |format|
				
				format.js { render plain: "0"}
				
			end
		end
	end
	def destroy
		@car = BusinessCar.find(params[:id])
		if @car.destroy
			# render plain: "1"
			respond_to  do |format|	
				format.js {render plain: "1"}
				format.html {redirect_to business_cars_path}
			end
		else
			# render plain: "0"
			# respond_to do |format|
			# 	format.js { render plain: "0"}
			# 	format.html { redirect_to business_cars_path, notice: "delete failed"}
			# end
		end

	end
	def  car_params
		params.require(:business_car).permit(:make, :model, :mileage, :nickname)
	end
end