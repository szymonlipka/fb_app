require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /dashboard" do
  	let(:user) {User.create!(:username => 'Szymon', :email => 'szymon.lipka@op.pl', :password => '123456', :password_confirmation => '123456')}
    it "works!" do
      get dashboard_path(user.id)
      expect(response).to have_http_status(200)
    end
  end
end
