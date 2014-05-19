class BusinessCar < ActiveRecord::Base
	validates :mileage, numericality: true
end