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

end