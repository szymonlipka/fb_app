class GroupsController < ApplicationController
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
	end
	private
	def group_params
      	params.require(:group).permit(:name)
    end
end