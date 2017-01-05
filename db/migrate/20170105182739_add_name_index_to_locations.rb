class AddNameIndexToLocations < ActiveRecord::Migration
  def change
    add_index :locations, [:name, :address], unique: true
  end
end
