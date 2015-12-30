class Group < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :memberships
  has_many :users, through: :memberships
  has_many :posts
  has_many :invitations

  def users_invited
    list = []
    invitations.each do |invite|
      list << invite[:user_id]
    end
    list
  end

  def already_invited?(user_id)
    self.users_invited.include?(user_id)
  end

end
