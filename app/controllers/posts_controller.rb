class PostsController < ApplicationController
	def create
		post = Post.create!(post_params)
		redirect_to group_path(params[:post][:group_id]) 
	end
	private
	def post_params
      	params.require(:post).permit(:content, :user_id, :group_id)
    end
end