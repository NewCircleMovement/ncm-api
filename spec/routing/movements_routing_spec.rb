require "rails_helper"

RSpec.describe MovementsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/movements").to route_to("movements#index")
    end

    it "routes to #show" do
      expect(:get => "/movements/1").to route_to("movements#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/movements").to route_to("movements#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/movements/1").to route_to("movements#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/movements/1").to route_to("movements#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/movements/1").to route_to("movements#destroy", :id => "1")
    end
  end
end
