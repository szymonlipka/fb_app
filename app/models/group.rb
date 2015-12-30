class Group < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :memberships
  has_many :users, through: :memberships
  has_many :posts
  has_many :invitations

  def already_invited?(user_id)
    invitations.exists?(user_id: user_id)
  end

end
