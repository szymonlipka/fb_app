require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "routing" do

    it "routes to #new" do
      expect(:get => "/signup").to route_to("users#new")
    end

    it "routes to #show" do
      expect(:get => "/dashboard/1").to route_to("users#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/signup").to route_to("users#create")
    end
  end
end
