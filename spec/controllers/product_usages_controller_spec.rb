require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe ProductUsagesController, type: :controller do

  let(:user) { create :user }
  let!(:product_usage) { create :product_usage, user: user }

  before { login user }

  describe "GET #index" do
    it "assigns all product_usages as @product_usages" do
      get :index, params: {}
      expect(assigns(:product_usages)).to eq([product_usage])
    end
  end

  describe "GET #show" do
    it "assigns the requested product_usage as @product_usage" do
      get :show, params: {id: product_usage.to_param}
      expect(assigns(:product_usage)).to eq(product_usage)
    end
  end

  describe "GET #new" do
    it "assigns a new product_usage as @product_usage" do
      get :new, params: {}
      expect(assigns(:product_usage)).to be_a_new(ProductUsage)
    end
  end

  describe "GET #edit" do
    it "assigns the requested product_usage as @product_usage" do
      get :edit, params: {id: product_usage.to_param}
      expect(assigns(:product_usage)).to eq(product_usage)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new ProductUsage" do
        expect {
          post :create, params: {product_usage: attributes_for(:product_usage)}
        }.to change(ProductUsage, :count).by(1)
      end

      it "assigns a newly created product_usage as @product_usage" do
        post :create, params: {product_usage: attributes_for(:product_usage)}
        expect(assigns(:product_usage)).to be_a(ProductUsage)
        expect(assigns(:product_usage)).to be_persisted
      end

      it "redirects to the created product_usage" do
        post :create, params: {product_usage: attributes_for(:product_usage)}
        expect(response).to redirect_to(ProductUsage.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved product_usage as @product_usage" do
        post :create, params: {product_usage: attributes_for(:product_usage, product_name: nil)}
        expect(assigns(:product_usage)).to be_a_new(ProductUsage)
      end

      it "re-renders the 'new' template" do
        post :create, params: {product_usage: attributes_for(:product_usage, product_name: nil)}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested product_usage" do
        put :update, params: {
          id: product_usage.to_param,
          product_usage: attributes_for(:product_usage, product_name: "A new name")
        }
        product_usage.reload
        expect(product_usage.product_name).to eq('A new name')
      end

      it "assigns the requested product_usage as @product_usage" do
        put :update, params: {
          id: product_usage.to_param,
          product_usage: attributes_for(:product_usage, product_name: "A new name")
        }
        expect(assigns(:product_usage)).to eq(product_usage)
      end

      it "redirects to the product_usage" do
        put :update, params: {
          id: product_usage.to_param,
          product_usage: attributes_for(:product_usage)
        }
        expect(response).to redirect_to(product_usage)
      end
    end

    context "with invalid params" do
      it "assigns the product_usage as @product_usage" do
        put :update, params: {
          id: product_usage.to_param,
          product_usage: attributes_for(:product_usage, product_name: "")
        }
        expect(assigns(:product_usage)).to eq(product_usage)
      end

      it "re-renders the 'edit' template" do
        put :update, params: {
          id: product_usage.to_param,
          product_usage: attributes_for(:product_usage, product_name: "")
        }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested product_usage" do
      expect {
        delete :destroy, params: {id: product_usage.to_param}
      }.to change(ProductUsage, :count).by(-1)
    end

    it "redirects to the product_usages list" do
      delete :destroy, params: {id: product_usage.to_param}
      expect(response).to redirect_to(product_usages_url)
    end
  end

end
