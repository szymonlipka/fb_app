class GroupsController < ApplicationController
  before_action :authenticate_user!

  def create
    @group = Group.new(group_params)
    if @group.save
      current_user.groups << @group
      redirect_to dashboard_path(current_user.id)
    else
      @user = current_user
      respond_to do |format|
        format.html { render :template => "users/show" }
        format.json { render json: @group.errors }
        format.json { render json: @user}
      end
    end
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.order('created_at DESC').paginate(page: params[:page], per_page: 10)
    @post = @group.posts.build
  end

  def add_user
    # TODO rebuild
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

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
