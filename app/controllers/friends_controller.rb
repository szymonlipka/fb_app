class FriendsController < ApplicationController
  before_action :authenticate_user!
  
  def invite
    user = User.find(params[:friend_id])
    if !current_user.friends.include?(user) && !user.already_invited?(user.id)
      invitation = user.invitations.build(inviter_username: current_user.username, friend_id: current_user.id)
      invitation.save
      flash[:notice] = "You've successfully invited guy to your friends"
    else
      flash[:alert] = "You can't invite him"
    end
    redirect_to dashboard_path(user.id)
  end

  def remove
    user = User.find(params[:friend_id])
    current_user.friends.destroy(user)
    user.friends.destroy(current_user)
    redirect_to dashboard_path(user.id)
  end

end
  