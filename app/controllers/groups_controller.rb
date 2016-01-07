class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :member_of_group?, only: [:add_user, :show]
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
    params[:ids].split(" ").each do |id|
      user = User.find(id.to_i)
        if (!@group.already_invited?(user.id) && !@group.users.include?(user))
          invitation = user.invitations.build(inviter_username: current_user.username, group_name: @group.name)
          @group.invitations << invitation
          invitation.save
          flash[:notice] = "You've successfully invited guys to your group"
        else
          flash[:alert] = "You can't invite #{user.name}"
        end
      end
    redirect_to @group
  end

  private

  def member_of_group?
    @group = Group.find(params[:id])
    render status: 401 unless current_user.groups.include?(@group)
  end

  def group_params
    params.require(:group).permit(:name)
  end
end
