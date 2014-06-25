class AddDefaultDriverToCars < ActiveRecord::Migration
  def change
  	change_column :business_cars, :driver_id, :integer, :default => 1
  end
end
