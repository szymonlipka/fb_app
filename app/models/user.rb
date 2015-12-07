class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	validates :username,  presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
	                format: { with: VALID_EMAIL_REGEX },
	                uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }
  	has_many :memberships
  	has_many :groups, through: :memberships
  	has_many :posts
 	def add_to_group(group_id, user_id)
 		group = Group.find(group_id)
  		if self.groups.include? group
  			user = User.find(user_id)
         	if !user.groups.include? group
         		user.groups << group
         		true
         	else
         		false
         	end
  		end
  	end
  	def list_posts
  		list = []
  		self.groups.each do |group|
  			group.posts.each do |post|
  				list << post
  			end
  		end
  		self.posts.each do |post|
  			list << post if !list.include? post
  		end
  		list.sort_by!(&:created_at)
  		list.reverse
  	end
end
