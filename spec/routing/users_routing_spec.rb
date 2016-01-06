require "rails_helper"

RSpec.describe Devise, type: :routing do
  describe "routing" do

    it "routes to registrations#new" do
      expect(:get => "/sign_up").to route_to("devise/registrations#new")
    end

    it "routes to sessions#new" do
      expect(:get => "/sign_in").to route_to("devise/sessions#new")
    end

    it "routes to sessions#destroy" do
      expect(:get => "/sign_out").to route_to("devise/sessions#destroy")
    end

  end
end
