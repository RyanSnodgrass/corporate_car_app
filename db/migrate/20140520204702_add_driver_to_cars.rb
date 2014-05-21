class AddDriverToCars < ActiveRecord::Migration
  def change
  	add_column :business_cars, :driver_id, :integer
  end
end
