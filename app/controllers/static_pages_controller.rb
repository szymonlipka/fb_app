class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: :create
	
  def home
		@posts = current_user.list_posts.paginate(:page => params[:page], :per_page => 30) if current_user
    @post = Post.new
	end

end
