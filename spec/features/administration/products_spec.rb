require "rails_helper"

module Administration
  RSpec.describe "Products", type: :feature do
    
    let!(:admin) { create :admin }
    let!(:product1) {
      create :product,
              brand: "ABC",
              name: "XYZ",
              created_at: 3.days.ago
    }

    let!(:product2) {
      create :product,
              brand: "DEF",
              name: "UVW",
              created_at: 4.days.ago
    }


    before do
      login admin

      create :usage_manifest,
              product: product1,
              status: :used

      create :usage_manifest,
              product: product1,
              status: :used

      create :approved_usage_manifest,
              product: product1,
              status: :using,
              approved_image: create(:approval_image, product: product1)

      create :approved_usage_manifest,
              product: product2,
              status: :using,
              approved_image: create(:approval_image, product: product2)

      create :approved_usage_manifest,
              product: product2,
              status: :using,
              approved_image: create(:approval_image, product: product2)

      create :usage_manifest,
              product: product2,
              status: :used

      visit administration_path
      click_link "PRODUCTS (2)"
    end

    it "get products" do
      expect(page).to have_content("PRODUCTS (2)")
      expect(page).to have_css("tbody tr", count: 2)
    end

    it "sorts default by created_at" do
      check_table_row_sorting %w(DEF ABC)
      click_link "Created At"
      check_table_row_sorting %w(ABC DEF)
    end

    it "sorts by brand" do
      click_link "Brand"
      check_table_row_sorting %w(ABC DEF)

      click_link "Brand"
      check_table_row_sorting %w(DEF ABC)
    end

    it "sorts by name" do
      click_link "Name"
      check_table_row_sorting %w(UVW XYZ)

      click_link "Name"
      check_table_row_sorting %w(XYZ UVW)
    end

    it "sorts by used_users_count" do
      click_link "Used Users Count"
      check_table_row_sorting %w(UVW XYZ)

      click_link "Used Users Count"
      check_table_row_sorting %w(XYZ UVW)
    end

    it "sorts by using_users_count" do
      click_link "Using Users Count"
      check_table_row_sorting %w(XYZ UVW)

      click_link "Using Users Count"
      check_table_row_sorting %w(UVW XYZ)
    end


  end
end