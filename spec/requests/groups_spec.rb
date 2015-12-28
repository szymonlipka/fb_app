require 'rails_helper'

RSpec.describe "Groups", type: :request do
	describe "GET /group" do
		let(:group) { Group.create!(name: 'Group') }
		it "works" do
			get group_path(group)
			expect(response).to have_http_status(200)
		end
	end
end