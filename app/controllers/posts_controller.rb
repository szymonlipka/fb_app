class PostsController < ApplicationController
  before_action :authenticate_user!, only: :create
  
  def index
    @posts = current_user.list_posts.paginate(:page => params[:page], :per_page => 30) if current_user
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        @posts = current_user.list_posts.paginate(:page => params[:page], :per_page => 30)
        format.js
      else
        @posts = current_user.list_posts.paginate(:page => params[:page], :per_page => 30)
        format.js
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :user_id, :group_id)
  end

end
