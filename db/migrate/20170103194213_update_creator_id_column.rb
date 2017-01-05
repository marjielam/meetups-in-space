class UpdateCreatorIdColumn < ActiveRecord::Migration
  def change
      remove_column(:meetups, :user_id)
      add_reference(:meetups, :creator)
  end
end
