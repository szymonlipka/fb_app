class Group < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :memberships
  has_many :users, through: :memberships
  has_many :posts
  has_many :invitations
  has_many :users_invited, through: :invitations, source: :user

  def already_invited?(user_id)
    invitations.exists?(group_id: id, user_id: user_id)
  end

end
