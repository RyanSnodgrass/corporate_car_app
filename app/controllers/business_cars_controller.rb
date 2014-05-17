class BusinessCarsController < ApplicationController
	def index
		@cars = BusinessCar.all
	end
end