class UpdateDefaultFKeyToFirstRecord < ActiveRecord::Migration
  def change
  	change_column :business_cars, :driver_id, :integer, :default => Driver.first.id
  end
end
