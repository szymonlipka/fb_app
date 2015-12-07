class GroupsController < ApplicationController
	def create
		group = Group.create!(group_params)
		current_user.groups << group
		redirect_to dashboard_path(current_user)
	end
	def show
		@group = Group.find(params[:id])
	end
	private
	def group_params
      	params.require(:group).permit(:name)
    end
end