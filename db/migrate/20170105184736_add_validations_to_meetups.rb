class AddValidationsToMeetups < ActiveRecord::Migration
  def change
    change_column_null :meetups, :description, false
    change_column_null :meetups, :location_id, false
    change_column_null :meetups, :creator_id, false

    add_index :meetups, [:name, :location_id], unique: true
  end
end
