class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  validates :inviter_username, presence: true
end
