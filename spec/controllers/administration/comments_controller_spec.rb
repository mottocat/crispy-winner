require "rails_helper"

module Administration

  RSpec.describe CommentsController, type: :controller do
    
    it "GET #index" do
      allow(controller).to receive(:current_user).and_return(build_stubbed :admin)
      allow(Comment).to receive(:order).and_return(comments = double)
      get :index
      expect(assigns(:comments)).to eq(comments)
    end

  end

end