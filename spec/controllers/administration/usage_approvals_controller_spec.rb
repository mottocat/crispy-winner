require "rails_helper"

module Administration

  RSpec.describe UsageApprovalsController, type: :controller do
    
    it "GET #index" do
      allow(controller).to receive(:current_user).and_return(build_stubbed :admin)
      allow(ApprovalImage).to receive(:order).and_return(approval_images = double)
      get :index
      expect(assigns(:approval_images)).to eq(approval_images)
    end

  end

end