class Groups::PostsController < GroupsController
  before_action :find_group
  before_action :check_privileges

  def create
    @post = current_user.posts.build(post_params)
    @post.group = @group
    respond_to do |format|
      if @post.save
        @posts = @group.posts.order('created_at DESC').paginate(page: params[:page], per_page: 10)
        format.js
      else
        @posts = @group.posts.order('created_at DESC').paginate(page: params[:page], per_page: 10)
        format.js
      end
    end
  end

  private

  def check_privileges
    render status: 401 unless current_user.groups.include?(@group)
  end

  def find_group
    @group = Group.find(params[:group_id])
  end

  def post_params
    params.require(:post).permit(:content, :user_id, :group_id)
  end
end
