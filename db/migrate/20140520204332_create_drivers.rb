class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
    	t.string :name
    end
  end
end
