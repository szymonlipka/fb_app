class DashboardsController < ApplicationController
  before_action :set_user, only: :show
  before_action :authenticate_user!, except: :show

  def show
    @group = Group.new
  end

  def invite_friend
    if user = User.find(params[:friend_id])
      if !current_user.friends.include?(user) && !user.already_invited?(user.id)
        invitation = user.invitations.build(inviter_username: current_user.username, friend_id: current_user.id)
        invitation.save
        flash[:notice] = "You've successfully invited guy to your friends"
      else
        flash[:alert] = "You can't invite him"
      end
    else
      flash[:alert] = "We didn't find this id"
    end
    redirect_to dashboard_path(user.id)
  end

  def remove_friend
    user = User.find(params[:friend_id])
    current_user.friends.destroy(user)
    user.friends.destroy(current_user)
    redirect_to dashboard_path(user.id)
  end

  def accept_invitation
    @invitation = Invitation.find(params[:invite])
    current_user.accept_invite(@invitation)
    flash[:notice] = "You've successfully accepted invitation"
    redirect_to dashboard_path(current_user.id)
  end

  def decline_invitation
    @invitation = Invitation.find(params[:invite])
    current_user.decline_invite(@invitation)
    flash[:notice] = "You've successfully declined invitaion"
    redirect_to dashboard_path(current_user.id)
  end

  private

  def check_privilages
    @invitation = Invitation.find(params[:invite])
    render status: 401 unless invitation.user == current_user
  end
    
  def set_user
    @user = User.find(params[:id])
  end

end