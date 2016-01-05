class AddFriendIdToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :friend_id, :integer
  end
end
