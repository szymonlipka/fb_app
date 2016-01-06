class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :omniauthable, omniauth_providers: [:facebook], 
         password_length: 6..128
  before_save :capi
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :posts
  has_many :invitations
  has_many :groups_pending, through: :invitations, source: :group
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  validates :first_name, presence: true, length: { maximum: 20 }
  validates :last_name, presence: true, length: { maximum: 20 }

  def name
    first_name + " " + last_name
  end

  def capi
    first_name.capitalize!
    last_name.capitalize!
  end
  
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
      user.first_name = auth.info.name.split(" ")[0]
      user.last_name = auth.info.name.split(" ")[1]
    end
  end

  def already_invited?(user_id)
    invitations.exists?(friend_id: user_id, user_id: id) || invitations.exists?(user_id: user_id, friend_id: id)
  end

  def accept_invite(invitation)
    if invitation.group_id
      group = Group.find(invitation.group_id)
      groups << group unless groups.include?(group)
    else
      friend = User.find(invitation.friend_id)
      friends << friend unless friends.include?(friend)
    end
    invitation.destroy
  end

  def decline_invite(invitation)
    invitation.destroy
  end

  def list_posts
    group_posts = Post.where(group_id: groups.pluck(:id)).where_values.reduce(:and)
    friend_posts = Post.where(user_id: friends.pluck(:id), group_id: nil).where_values.reduce(:and)
    inverse_friend_posts = Post.where(user_id: inverse_friends.pluck(:id), group_id: nil).where_values.reduce(:and)
    Post.where(Post.arel_table[:user_id].eq(id).or(group_posts).or(friend_posts).or(inverse_friend_posts)).order('created_at DESC')
  end

end
