require 'rails_helper'

RSpec.describe "Usage Manifest", type: :feature do

  let(:user) { create :user }
  let(:product) { create :product }

  before {
    login user
    visit product_path(product)
  }

  it "user can check the product as used" do
    select "I used this product before"
    click_on "Save"

    expect(page).to have_content("I used this product before")
  end

  it "user can check the product as using" do
    select "I am using this product now"
    click_on "Save"

    expect(page).to have_content("I am using this product now")
  end

  it "user can cancel to the product usage status" do
    user.use!(product)

    visit product_path(product)
    click_link "Cancel" 

    expect(page).to_not have_content("I am using this product now.")
    expect(page).to_not have_content("I used this product before.")
  end

  it "shows total used or using users" do
    user.use! product, status: :using
    usage_manifest = user.usage_manifest_for(product)
    usage_manifest.update! approved_image: create(:approval_image, user: user, product: product)
    visit product_path(product)
    expect(page).to have_content("1 using")

    user.use! product, status: :used
    visit product_path(product)
    expect(page).to have_content("1 used")
  end

end