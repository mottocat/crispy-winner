require "rails_helper"

RSpec.describe "Product", type: :feature do
  

  it "creates a new product" do
    login create(:admin)
    visit new_product_path
    expect {
      fill_in "product_name", with: "The Product Name"
      fill_in "product_brand" , with: "The Brand"
      click_button "Create Product"
    }.to change(Product, :count).by(1)
  end

  it "seems on product index page" do
    create :product, name: "The Product Name"
    visit products_path
    expect(page).to have_content("The Product Name")
  end

  it "shows product using count on index page" do
    user = create :user
    product = create :product
    approved_image = create :approval_image, product: product, user: user
    create :usage_manifest, user: user, product: product, status: :using, approved_image: nil 
    create :usage_manifest, user: user, product: product, status: :using, approved_image: approved_image

    visit products_path
    expect(page).to have_content("1 using")
  end

  it "shows product used count on index page" do
    user = create :user
    product = create :product

    2.times do
      create :usage_manifest, user: user, product: product, status: :used
    end

    visit products_path
    expect(page).to have_content("2 used")
  end

  it "searchs products", js: true do
    create :product, name: "XYZ Mobile"
    create :product, brand: "ABC Biscuits"
    visit products_path

    fill_in "q", with: "XYZ"
    page.execute_script("document.getElementById('search_form').submit();")
    expect(page).to have_content("XYZ Mobile")

    fill_in "q", with: "ABC"
    page.execute_script("document.getElementById('search_form').submit()")
    expect(page).to have_content("ABC Biscuits")
  end


end