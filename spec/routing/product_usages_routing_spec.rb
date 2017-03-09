require "rails_helper"

RSpec.describe ProductUsagesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/product_usages").to route_to("product_usages#index")
    end

    it "routes to #new" do
      expect(:get => "/product_usages/new").to route_to("product_usages#new")
    end

    it "routes to #show" do
      expect(:get => "/product_usages/1").to route_to("product_usages#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/product_usages/1/edit").to route_to("product_usages#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/product_usages").to route_to("product_usages#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/product_usages/1").to route_to("product_usages#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/product_usages/1").to route_to("product_usages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/product_usages/1").to route_to("product_usages#destroy", :id => "1")
    end

  end
end
