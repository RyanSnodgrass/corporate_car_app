class BusinessCar < ActiveRecord::Base
	validates :mileage, numericality: true
	belongs_to :driver
end