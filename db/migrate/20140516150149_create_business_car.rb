class CreateBusinessCar < ActiveRecord::Migration
  def change
    create_table :business_cars do |t|
    	t.string :make
    	t.string :model
    	t.integer :mileage
    	t.string :nickname
    end
  end
end
