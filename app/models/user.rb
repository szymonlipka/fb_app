class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :omniauthable, omniauth_providers: [:facebook], 
         password_length: 6..128
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :posts
  has_many :invitations
  validates :username, presence: true
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
      user.username = auth.info.name
    end
  end
  def accept_invite(invitation)
    group = Group.find(invitation.group_id)
    (!self.groups.include? group) ? groups << group : false
    invitation.delete
  end
  def decline_invite(invitation)
    invitation.delete
  end
  def list_posts
    list = []
    groups.each do |group|
      group.posts.each do |post|
        list << post
      end
    end
    posts.each do |post|
      list << post if !list.include? post
    end
    list.sort_by!(&:created_at)
    list.reverse
  end
end
