require "rails_helper"

module Administration
  RSpec.describe "Products", type: :feature do
    
    let!(:admin) { create :admin }

    before do
      login admin

      create :product,
              brand: "ABC",
              name: "XYZ",
              created_at: 3.days.ago

      create :product,
              brand: "DEF",
              name: "UVW",
              created_at: 4.days.ago

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

  end
end