class DashboardsController < ApplicationController
  before_action :set_user, only: :show
  before_action :authenticate_user!, except: :show

  def show
    @user = User.find(params[:id])
    @group = Group.new
  end

  def accept_invitation
    invitation = Invitation.find(params[:invite])
    current_user.accept_invite(invitation)
    flash[:notice] = "You've successfully joined group"
    redirect_to dashboard_path(current_user.id)
  end

  def decline_invitation
    invitation = Invitation.find(params[:invite])
    current_user.decline_invite(invitation)
    flash[:notice] = "You've successfully rejected joining group"
    redirect_to dashboard_path(current_user.id)
  end

  private
    
  def set_user
    @user = User.find(params[:id])
  end
end
