class StaticPagesController < ApplicationController
	def home
		@posts = current_user.list_posts if current_user
	end
end
