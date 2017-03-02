require 'rails_helper'

RSpec.describe UsageManifestsController, type: :controller do

  let(:product) { create :product }
  let(:user) { create :user }

  before { login user }

  describe "POST #create" do
    it "creates a new UsageManifest" do
      expect {
        post :create, params: {
          product_id: product.to_param, 
          usage_manifest: attributes_for(:usage_manifest)
        }
      }.to change(UsageManifest, :count).by(1)
    end

    it "assigns a newly created usage manifest as @usage_manifest" do
      post :create, params: {
        product_id: product.to_param, 
        usage_manifest: attributes_for(:usage_manifest)
      }
      expect(assigns(:usage_manifest)).to be_a(UsageManifest)
      expect(assigns(:usage_manifest)).to be_persisted
    end

    it "redirects to the created product" do
      post :create, params: {
        product_id: product.to_param, 
        usage_manifest: attributes_for(:usage_manifest)
      }
      expect(response).to redirect_to(product)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested product" do
      user.use! product
      expect {
        delete :destroy, params: {product_id: product.to_param}
      }.to change(UsageManifest, :count).by(-1)
    end

    it "redirects to the products list" do
      delete :destroy, params: {product_id: product.to_param}
      expect(response).to redirect_to(product)
    end
  end

end
