class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  # GET /users/1
  # GET /users/1.json
  def show
      @user = User.find(params[:id])
  end
  def add_user_to_group
    if @user = User.find_by(username: params[:invite][:username])
      if current_user.add_to_group(params[:invite][:group_id], @user.id)
        flash[:notice] = "You've successfully added guy to your group"
      else
        flash[:alert] = "You can't add him"
      end
    else
      flash[:alert] = "We didn't find this username"
    end
    redirect_to group_path(params[:invite][:group_id])
  end
  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        log_in @user
        format.html { redirect_to dashboard_path(@user.id), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  private
    def set_user
      @user = User.find(params[:id])
    end
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
