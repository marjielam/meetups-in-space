class CreateCommitments < ActiveRecord::Migration
  def change
    create_table :commitments do |table|
      table.belongs_to :user, index: true
      table.belongs_to :meetup, index: true

      table.timestamps null: false
    end
  end
end
