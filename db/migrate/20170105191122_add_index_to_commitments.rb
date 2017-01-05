class AddIndexToCommitments < ActiveRecord::Migration
  def change
    add_index :commitments, [:user_id, :meetup_id], unique: true 
  end
end
