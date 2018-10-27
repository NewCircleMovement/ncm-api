require "rails_helper"

RSpec.describe TribesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/tribes").to route_to("tribes#index")
    end

    it "routes to #show" do
      expect(:get => "/tribes/1").to route_to("tribes#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/tribes").to route_to("tribes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/tribes/1").to route_to("tribes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/tribes/1").to route_to("tribes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/tribes/1").to route_to("tribes#destroy", :id => "1")
    end
  end
end
