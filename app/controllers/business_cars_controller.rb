class BusinessCarsController < ApplicationController
	# respond_to :json
	

	def index
		@cars = BusinessCar.all
	end
	def create
		 @car = BusinessCar.new(car_params)
		if @car.save

			render @car

		else
			render nothing: true
		end
	end

	def update
		@car = BusinessCar.find(params[:id])
		if @car.update_attributes(car_params)
			render json: @car
		else
			render plain: "0"
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
			render plain: "0"
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