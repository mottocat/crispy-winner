require "rails_helper"

module Administration
  RSpec.describe "Usage Approval", type: :feature do
    
    let!(:admin) { create :admin }
    let(:user1) { create :user, first_name: "Ali" }
    let(:user2) { create :user, first_name: "Veli" }
    let(:product1) { create :product, brand: "ABC" }
    let(:product2) { create :product, brand: "DEF" }
    # let!(:usage_manifest1) { 
    #   create :usage_manifest,
    #           product: product1,
    #           author: user1,
    #           created_at: 1.day.ago,
    #           status: :using
    # }

    # let!(:usage_manifest2) {
    #   create :usage_manifest,
    #           product: product2,
    #           author: user2,
    #           created_at: 2.days.ago,
    #           status: :using
    # }
    let!(:approval_image1) {
      create :approval_image,
              product: product1,
              user: user1,
              created_at: 2.days.ago,
              updated_at: 47.hours.ago,
              status: :waiting_approval
    }

    let!(:approval_image2) {
      create :approval_image,
              product: product2,
              user: user2,
              created_at: 1.days.ago,
              updated_at: 23.hours.ago,
              status: :denied
    }

    before do
      login admin

      visit administration_path
      click_link "USAGE APPROVAL (2)"
    end

    it "get products" do
      expect(page).to have_content("USAGE APPROVAL (2)")
      expect(page).to have_css("tbody tr", count: 2)
    end

    it "sorts default by created_at" do
      check_table_row_sorting %w(ABC DEF)
      click_link "Created At"
      check_table_row_sorting %w(DEF ABC)
    end

    it "sorts by product" do
      within "th:first-child" do
        click_link "Product"
      end
      check_table_row_sorting %w(ABC DEF)

      within "th:first-child" do
        click_link "Product"
      end  
      check_table_row_sorting %w(DEF ABC)
    end

    it "sorts by user" do
      within "th:nth-child(2)" do
        click_link "User"
      end
      check_table_row_sorting %w(Ali Veli)

      within "th:nth-child(2)" do
        click_link "User"
      end
      check_table_row_sorting %w(Veli Ali)
    end

    it "sorts by updated_at" do
      click_link "Updated At"
      check_table_row_sorting %w(ABC DEF)

      click_link "Updated At"
      check_table_row_sorting %w(DEF ABC)
    end

  end
end