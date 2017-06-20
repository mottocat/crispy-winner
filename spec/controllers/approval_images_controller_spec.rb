require 'rails_helper'

RSpec.describe ApprovalImagesController, type: :controller do

  let(:user) { create :user }
  let(:admin) { create :admin }
  let!(:product) { create :product }

  before do
    sign_in user
  end

  it "#index" do
    sign_in admin
    get :index, params: { product_id: product.id}
    expect(response).to have_http_status(:success)
  end

  it "#create" do
    expect {
      post :create, params: {product_id: product.id, approval_image: attributes_for(:approval_image)}
    }.to change(ApprovalImage, :count).by(1)
  end

  it "#update" do
    approval_image = create :approval_image, product: product, user: user

    expect {
      put :update, params: {
        product_id: product.id,
        id: approval_image.id, 
        approval_image: attributes_for(:approval_image) }
    }.to_not change(ApprovalImage, :count)
  end

  describe "send email" do

    let!(:approval_image) { create :approval_image, product: product, user: user }

    before do
      create :usage_manifest, product: product, user: user
    end

    it "doesnt send" do
      expect {
        put :update, params: {
          product_id: product.id,
          id: approval_image.id, 
          approval_image: attributes_for(:approval_image) }
      }.to_not change {ActionMailer::Base.deliveries.count }
    end

    it "sends an email when status is approved" do
      expect {
        put :update, params: {
          product_id: product.id,
          id: approval_image.id, 
          approval_image: attributes_for(:approval_image).merge(status: :approved) }
      }.to change { ActionMailer::Base.deliveries.count }
    end

    it "sends an email when status is denied" do
      expect {
        put :update, params: {
          product_id: product.id,
          id: approval_image.id, 
          approval_image: attributes_for(:approval_image).merge(status: :denied) }
      }.to change { ActionMailer::Base.deliveries.count }
    end
  end

end
