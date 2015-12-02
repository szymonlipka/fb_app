class User < ActiveRecord::Base
	attr_accessor :password
  	EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  	validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  	validates :email, :presence => true, :uniqueness => true
  	validates :password, :confirmation => true #password_confirmation attr
  	validates_length_of :password, :in => 6..20, :on => :create
  	has_many :memberships
  	has_many :groups, through: :memberships
 	def add_to_group(group_id, user_id)
 		group = Group.find(group_id)
  		if self.groups.include? group
  			User.find(user_id).groups << group
  		end
  	end
end
