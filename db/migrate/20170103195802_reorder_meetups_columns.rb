class ReorderMeetupsColumns < ActiveRecord::Migration
  def change
    change_table :meetups do |table|
      table.change :creator_id, :integer, after: :location_id
    end
  end
end
