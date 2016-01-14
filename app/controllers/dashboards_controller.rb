class DashboardsController < ApplicationController
  before_action :set_user, only: :show
  before_action :authenticate_user!, except: :show

  def show
    @group = Group.new
  end

  private
    
  def set_user
    @user = User.find(params[:id])
  end

end