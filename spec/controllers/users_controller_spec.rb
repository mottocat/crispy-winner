require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) { create :user }

  it "GET #show" do
    get :show, params: {id: user.to_param}
    expect(assigns(:user)).to eq(user)
  end

end
