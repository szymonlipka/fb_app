class CreateInvitations < ActiveRecord::Migration
  def change
    create_table "invitations" do |t|
      t.integer :user_id
      t.integer :group_id
      t.string :inviter_username
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
