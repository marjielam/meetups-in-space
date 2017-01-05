class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |table|
      table.string :name, null: false
      table.text :description
      table.belongs_to :user, null: false
      table.belongs_to :location, index: true

      table.timestamps null: false
    end
  end
end
