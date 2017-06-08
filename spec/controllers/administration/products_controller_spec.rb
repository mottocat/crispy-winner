require "rails_helper"

module Administration

  RSpec.describe ProductsController, type: :controller do
    
    it "GET #index" do
      allow(controller).to receive(:current_user).and_return(build_stubbed :admin)
      allow(Product).to receive(:order).and_return(products = double)
      get :index
      expect(assigns(:products)).to eq(products)
    end

  end

end