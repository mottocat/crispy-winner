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

RSpec.describe ProductsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Product. As you add validations to Product, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      name: "Product Name",
      brand: "Brand Name"
    }
  }

  let(:invalid_attributes) {
    {
      name: "",
      brand: ""
    }
  }

  let(:valid_session) { {} }
  let!(:product) { Product.create! valid_attributes}
  let(:user) { create :user }
  let(:admin) { create :admin }

  describe "GET #index" do
    it "assigns all products as @products" do
      get :index
      expect(assigns(:products)).to eq([product])
    end
  end

  describe "GET #show" do
    it "assigns the requested product as @product" do
      get :show, params: {id: product.to_param}
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "GET #new" do
    it "assigns a new product as @product" do
      allow(controller).to receive(:current_user).and_return(user)
      get :new
      expect(assigns(:product)).to be_a_new(Product)
    end
  end

  describe "GET #edit" do
    it "assigns the requested product as @product" do
      allow(controller).to receive(:current_user).and_return(admin)
      get :edit, params: {id: product.to_param}
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "POST #create" do
    before do
      allow(controller).to receive(:current_user).and_return(admin)
    end

    context "with valid params" do
      it "creates a new Product" do
        expect {
          post :create, params: {product: valid_attributes}
        }.to change(Product, :count).by(1)
      end

      it "assigns a newly created product as @product" do
        post :create, params: {product: valid_attributes}
        expect(assigns(:product)).to be_a(Product)
        expect(assigns(:product)).to be_persisted
      end

      it "redirects to the created product" do
        post :create, params: {product: valid_attributes}
        expect(response).to redirect_to(Product.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved product as @product" do
        post :create, params: {product: invalid_attributes}
        expect(assigns(:product)).to be_a_new(Product)
      end

      it "re-renders the 'new' template" do
        post :create, params: {product: invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    before do
      allow(controller).to receive(:current_user).and_return(admin)
    end

    context "with valid params" do
      let(:new_attributes) {
        {
          name: "New Product Name",
          brand: "New Brand Name"
        }
      }

      it "flashes the success message" do
        put :update, params: {id: product.to_param, product: new_attributes}
        expect(flash[:notice]).to eq("Product was successfully updated.")
      end

      it "updates the requested product" do
        put :update, params: {id: product.to_param, product: new_attributes}
        product.reload
        expect(product.name).to eq("New Product Name")
        expect(product.brand).to eq("New Brand Name")
      end

      it "assigns the requested product as @product" do
        put :update, params: {id: product.to_param, product: valid_attributes}
        expect(assigns(:product)).to eq(product)
      end

      it "redirects to the product" do
        put :update, params: {id: product.to_param, product: valid_attributes}
        expect(response).to redirect_to(product)
      end
    end

    context "with invalid params" do
      it "assigns the product as @product" do
        product = Product.create! valid_attributes
        put :update, params: {id: product.to_param, product: invalid_attributes}
        expect(assigns(:product)).to eq(product)
      end

      it "re-renders the 'edit' template" do
        product = Product.create! valid_attributes
        put :update, params: {id: product.to_param, product: invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      allow(controller).to receive(:current_user).and_return(admin)
    end

    it "flashes the notice message" do
      delete :destroy, params: {id: product.to_param}
      expect(flash[:notice]).to eq("Product was successfully destroyed.")  
    end

    it "destroys the requested product" do
      expect {
        delete :destroy, params: {id: product.to_param}
      }.to change(Product, :count).by(-1)
    end

    it "redirects to the products list" do
      delete :destroy, params: {id: product.to_param}
      expect(response).to redirect_to(products_url)
    end
  end

end
