require "rails_helper"

RSpec.describe UsageManifestsController, type: :routing do
  describe "routing" do

    it "routes to #create" do
      expect(:post => "products/1/usage_manifests").to route_to("usage_manifests#create", product_id: "1")
    end

    it "routes to #destroy" do
      expect(:delete => "products/1/usage_manifests").to route_to("usage_manifests#destroy", :product_id => "1")
    end

  end
end
