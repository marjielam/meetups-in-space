class RequireUserAndMeetupInCommitments < ActiveRecord::Migration
  def change
    change_column_null :commitments, :user_id, false
    change_column_null :commitments, :meetup_id, false
  end
end
