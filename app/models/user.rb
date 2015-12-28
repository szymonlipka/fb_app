class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :omniauthable, :omniauth_providers => [:facebook], 
         password_length: 6..128
  attr_accessor :email, :username, :password, :password_confirmation, :uid, :provider
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :posts
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name.split(' ')[0]
    end
  end
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
