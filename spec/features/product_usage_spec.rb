require 'rails_helper'

RSpec.describe "product usage", type: :feature do
  
  let!(:user) { create :user }
  let!(:product_usage) { create :product_usage, user: user }

  before { login user }

  describe "create" do
    context "with valid attributes" do

      it "adds a new product usage" do
        visit new_product_usage_path

        expect {
          fill_in "product_usage_product_name", with: "Product Name"
          choose "I used this product"
          attach_file "Images", "#{Rails.root}/spec/support/images/products/product1.jpg"
          fill_in "product_usage_comment_body", with: "A new comment"
          click_on "Create Product usage"
        }.to change(ProductUsage, :count).by(1)
      end
    end

    context "with invalid attributes" do

      it "doenst add a new product usage" do
        visit new_product_usage_path

        expect {
          fill_in "product_usage_product_name", with: ""
          choose "I used this product"
          attach_file "Images", "#{Rails.root}/spec/support/images/products/product1.jpg"
          fill_in "product_usage_comment_body", with: "A new comment"
          click_on "Create Product usage"
        }.to_not change(ProductUsage, :count)
      end
    end
  end

  describe "update" do
    context "with valid attributes" do

      it "updates existing product usage" do
        visit edit_product_usage_path(product_usage)
        fill_in "product_usage_product_name", with: "A New Product Name"
        click_on "Update Product usage"
        product_usage.reload
        expect(product_usage.product_name).to eq("A New Product Name")
      end
    end

    context "with invalid attributes" do

      it "doenst update a new product usage" do
        visit edit_product_usage_path(product_usage)

        fill_in "product_usage_product_name", with: ""
        click_on "Update Product usage"

        product_usage.reload

        expect(product_usage.product_name).to_not eq("")

      end
    end
  end

  it "destroy" do
    visit product_usages_path

    expect {
      click_link "Destroy"
    }.to change(ProductUsage, :count).by(-1)
  end

end