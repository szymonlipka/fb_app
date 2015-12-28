class DashboardsController < ApplicationController
  before_action :set_user, only: :show

  def show
    @user = User.find(params[:id])
    @group = Group.new
  end

  private
    
  def set_user
    @user = User.find(params[:id])
  end
end
