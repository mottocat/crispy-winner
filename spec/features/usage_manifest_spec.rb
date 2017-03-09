require 'rails_helper'

RSpec.describe "Usage Manifest", type: :feature do

  let(:user) { create :user }
  let(:product) { create :product }

  before {
    login user
    visit product_path(product)
  }

  it "user can check the product as used" do
    select "used to use"
    click_on "Save"

    expect(page).to have_content("I used to use this product.")
  end

  it "user can check the product as using" do
    select "am using"
    click_on "Save"

    expect(page).to have_content("I am using this product.")
  end

  it "user can cancel to the product usage status" do
    user.use!(product)

    visit product_path(product)
    click_link "Cancel" 

    expect(page).to_not have_content("I am using this product.")
    expect(page).to_not have_content("I used to use this product.")
  end

  it "shows total used or using users" do
    user.use! product, status: :using
    visit product_path(product)
    expect(page).to have_content("1 users using this product now")

    user.use! product, status: :used
    visit product_path(product)
    expect(page).to have_content("1 users used this product before")
  end

end