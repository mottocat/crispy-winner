require "rails_helper"

module Administration

  RSpec.describe UsersController, type: :controller do
    
    it "GET #index" do
      allow(controller).to receive(:current_user).and_return(build_stubbed :admin)
      allow(User).to receive(:order).and_return(users = double)
      get :index
      expect(assigns(:users)).to eq(users)
    end

  end

end