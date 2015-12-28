class StaticPagesController < ApplicationController
	def home
		@posts = current_user.list_posts.paginate(:page => params[:page], :per_page => 30) if current_user
	end
end
