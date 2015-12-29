require 'rails_helper'

RSpec.describe "Groups", type: :request do
	describe "GET /groups" do
		let(:group) { Group.create!(name: 'Group') }
		it "works" do
			get group_path(group)
			expect(response).to have_http_status(302)
		end
	end
end