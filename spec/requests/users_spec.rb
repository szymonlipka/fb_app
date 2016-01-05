require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /dashboard" do
  	let(:user) {User.create!(first_name: 'Szymon', last_name: 'Lipka', :username => 'Szymon', :email => 'szymon.lipka@op.pl', :password => '123456', :password_confirmation => '123456')}
    it "works!" do
      get dashboard_path(user.id)
      expect(response).to have_http_status(200)
    end
  end
  describe "GET /signup" do
  	it "works!" do
  		get '/sign_up'
  		expect(response).to have_http_status(200)
  	end
  end
end
