require "rails_helper"

module Administration

  RSpec.describe BaseController, type: :controller do
    
    it "GET #index" do
      admin = create :admin
      sign_in admin
      get :index
      expect(response).to be_success
    end

  end

end