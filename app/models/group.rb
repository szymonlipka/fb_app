class Group < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	has_many :memberships
	has_many :users, through: :memberships
	has_many :posts
end
