require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /sign_up" do
    it "works!" do
      get '/sign_up'
      expect(response).to have_http_status(200)
    end
  end
  describe "GET /sign_in" do
    it "works!" do
      get '/sign_in'
      expect(response).to have_http_status(200)
    end
  end
end