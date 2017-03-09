require 'rails_helper'

RSpec.describe "ProductUsages", type: :request do
  describe "GET /product_usages" do
    it "works! (now write some real specs)" do
      get product_usages_path
      expect(response).to have_http_status(200)
    end
  end
end
