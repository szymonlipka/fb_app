class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_privilages
  
  def accept_invitation
    current_user.accept_invite(@invitation)
    flash[:notice] = "You've successfully accepted invitation"
    redirect_to dashboard_path(current_user.id)
  end

  def decline_invitation
    current_user.decline_invite(@invitation)
    flash[:notice] = "You've successfully declined invitaion"
    redirect_to dashboard_path(current_user.id)
  end

  private

  def check_privilages
    @invitation = Invitation.find(params[:invite])
    render status: 401 unless @invitation.user == current_user
  end

end